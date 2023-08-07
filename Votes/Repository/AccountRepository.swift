//
//  AccountRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/15.
//

import Foundation

protocol IAccountRepository {
    func createAccount(accountID: String, email: String, pass: String) async throws
    func getAccount(email: String, pass: String) async throws -> Account
    func updateAccount(account: Account) async throws
}

struct AccountRepository: IAccountRepository {
    private let fireStoreGateway: IFireStoreGateway
    
    init(fireStoreGateway: IFireStoreGateway) {
        self.fireStoreGateway = fireStoreGateway
    }
    
    func createAccount(accountID: String, email: String, pass: String) async throws {
        let data = AccountData(email: email, password: pass, userID: "")
        try await fireStoreGateway.create(.account(accountID: accountID), data)
        KeyChainService.shared.saveAccount(account: Account(accountID: accountID, email: email, password: pass, userID: ""))
    }
    
    func getAccount(email: String, pass: String) async throws -> Account {
        let accounts: [AccountData] = try await fireStoreGateway.getListWithQuery(.account(email: email, pass: pass))
        guard let doc = accounts.first else {
            throw NSError(domain: "not found", code: 5)
        }
        guard let accountID = doc.accountID else {
            throw NSError(domain: "not found", code: 400)
        }
        let data = Account(accountID: accountID, email: doc.email, password: doc.password, userID: doc.userID)
        KeyChainService.shared.saveAccount(account: data)
        return data
    }
    
    func getAccount(accountID: String) async throws -> Account {
        if let cache = try? KeyChainService.shared.getAccount(accountID: accountID) {
            return cache
        }
        let account: Account = try await fireStoreGateway.get(.account(accountID: accountID))
        KeyChainService.shared.saveAccount(account: account)
        return Account(accountID: accountID, email: account.email, password: account.password, userID: account.userID)
    }
    
    func updateAccount(account: Account) async throws {
        try await fireStoreGateway.create(.account(accountID: account.accountID), account)
        KeyChainService.shared.saveAccount(account: account)
    }
}

