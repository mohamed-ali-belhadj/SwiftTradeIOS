//
//  NFTLookupView.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import SwiftUI

struct NFTLookupView: View {
    public var tokens: [TokenDetailsEntity]
    var body: some View {
        ForEach(tokens, id: \.self) { token in
            HStack {
                if let symbol = token.tokenInfo?.symbol {
                    HStack {
                        if let url = URL(string: WebServiceConstants.imageBaseURL + (token.tokenInfo?.image ?? "") ) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .frame(width: 15, height: 15)
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                            }
                        }
                        Text(symbol)
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .lineLimit(1)
                        if let website = token.tokenInfo?.website {
                            WebsiteRedirectionButton(websiteAbsoluteString: website)
                        }
                    }
                    Spacer()
                    Text(token.balance ?? 0, format: .number.notation(.compactName).precision(.significantDigits(3)))
                        .font(.system(size: 12))
                        .lineLimit(1)
                }
            }
        }

    }
}

#Preview {
    NFTLookupView(tokens: [])
}
