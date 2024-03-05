//
//  WebsiteRedirectionButton.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import SwiftUI

struct WebsiteRedirectionButton: View {
    @Environment(\.openURL) private var openURL

    var websiteAbsoluteString: String

    init(websiteAbsoluteString: String) {
        self.websiteAbsoluteString = websiteAbsoluteString
    }

    var body: some View {
        Button {
            guard let url = URL(string: websiteAbsoluteString) else {
                return
            }
            openURL(url)
        } label: {
            Image(systemName: "arrow.up.right.square")
                .font(.system(size: 10))
        }
    }
}
