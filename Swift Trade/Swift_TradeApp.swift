//
//  Swift_TradeApp.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import SwiftUI
import SwiftData

@main
struct Swift_TradeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(DatabaseService.shared.container!)
        }
    }
}
