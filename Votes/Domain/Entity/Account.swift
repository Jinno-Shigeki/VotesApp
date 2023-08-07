//
//  Account.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/17.
//

import Foundation

struct Account: Codable {
    let accountID: String
    let email: String
    let password: String
    let userID: String
    
    init(accountID: String, email: String, password: String, userID: String) {
        self.accountID = accountID
        self.email = email
        self.password = password
        self.userID = userID
    }
    
    init() {
        self.accountID = ""
        self.email = ""
        self.password = ""
        self.userID = ""
    }
}
