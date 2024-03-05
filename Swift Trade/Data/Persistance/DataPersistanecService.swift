//
//  DataPersistanecService.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 04/03/2024.
//

import Foundation
import SwiftData

final class DatabaseService{
    static var shared = DatabaseService()
    var container: ModelContainer?
    var context: ModelContext?

    private init() {
        do {
            container = try ModelContainer(for: WalletDTO.self)
            if let container{
                context = ModelContext(container)
            }
        }
        catch{
            print(error)
        }
    }

    func save(model: WalletDTO){
        if let context {
            context.insert(model)
        }
    }

    func fetch(onCompletion:@escaping([WalletDTO]?,Error?)->(Void)){
        let descriptor = FetchDescriptor<WalletDTO>(sortBy: [SortDescriptor<WalletDTO>(\.address)])
        if let context{
            do {
                let data = try context.fetch(descriptor)
                onCompletion(data,nil)
            }
            catch {
                onCompletion(nil,error)
            }
        }
    }
}
