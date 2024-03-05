//
//  TextCopyButton.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import SwiftUI

struct TextCopyButton: View {
    @State private var showHint = false

    var text: String
    let pasteboard = UIPasteboard.general

    init(text: String, showHint: Bool = false) {
        self.text = text
        self.showHint = showHint
    }

    var body: some View {
        if showHint {
            Text("copied !")
                .font(.system(size: 10))
                .foregroundColor(.blue)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        showHint.toggle()
                    }
                }
        }
        else {
            Button {
                pasteboard.string = text
                showHint.toggle()
            } label: {
                Image(systemName: "doc.on.doc")
                    .font(.system(size: 10))
            }
        }
    }
}
