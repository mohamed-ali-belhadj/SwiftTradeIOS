//
//  APIClient.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import Combine
import UIKit

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        let excludeSuggestions = URLQueryItem(name: "exclude_suggestions", value: nil)


        var url = endpoint
            .baseURL
            .appendingPathComponent(endpoint.path)

        endpoint.parameters?.forEach { parameter in
            url = url.appending(queryItems: [URLQueryItem(name: parameter.key, value: parameter.value as? String)])
        }

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue

        // Set up any request headers or parameters here
        endpoint.headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        // Set up cache policy
        request.cachePolicy = endpoint.cachePolicy

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is Swift.DecodingError:
                    return APIError.invalidResponse
                case _ as URLError:
                    return APIError.invalidURL
                default:
                    return APIError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
