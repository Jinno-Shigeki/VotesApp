//
//  AccountRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/15.
//

import Foundation
import Entry

protocol IAccountRepository {
    func createAccount(accountID: String, email: String, pass: String) async throws
    func getAccount(email: String, pass: String) async throws -> Entry
    func updateAccount(entry: Entry) async throws
}

struct AccountRepository: IAccountRepository {
    private let fireStoreGateway: IFireStoreGateway
    
    init(fireStoreGateway: IFireStoreGateway) {
        self.fireStoreGateway = fireStoreGateway
    }
    
    func createAccount(accountID: String, email: String, pass: String) async throws {
        let data = AccountData(email: email, password: pass, userID: "")
        try await fireStoreGateway.create(.account(accountID: accountID), data)
        
        let entry = Entry(userID: accountID, userDisplayID: data.userID, email: email, password: pass)
        KeyChainService.shared.saveEntry(entry: entry)
    }
    
    func getAccount(email: String, pass: String) async throws -> Entry {
        let accounts: [AccountData] = try await fireStoreGateway.getListWithQuery(.account(email: email, pass: pass))
        guard let doc = accounts.first else {
            throw NSError(domain: "not found", code: 5)
        }
        guard let userID = doc.accountID else {
            throw NSError(domain: "not found", code: 400)
        }
        let data = Entry(userID: userID, userDisplayID: doc.userID, email: doc.email, password: doc.password)
        KeyChainService.shared.saveEntry(entry: data)
        return data
    }
    
//    func getAccount(accountID: String) async throws -> Entry {
//        if let cache = try? KeyChainService.shared.getAccount(accountID: accountID) {
//            return cache
//        }
//        let account: Account = try await fireStoreGateway.get(.account(accountID: accountID))
//        KeyChainService.shared.saveAccount(account: account)
//        return Account(accountID: accountID, email: account.email, password: account.password, userID: account.userID)
//    }
    
    func updateAccount(entry: Entry) async throws {
        try await fireStoreGateway.create(.account(accountID: entry.userID), entry)
        KeyChainService.shared.saveEntry(entry: entry)
    }
}

