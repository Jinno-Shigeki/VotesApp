//
//  Account.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/15.
//

import Foundation

public struct AccountData: Codable {
    public let accountID: String
    public let email: String
    public let password: String
    public let userID: String
    
    enum CodingKeys: String, CodingKey {
        case accountID = "id"
        case email
        case password
        case userID = "user_id"
    }
    
    public init(accountID: String, email: String, password: String, userID: String) {
        self.accountID = accountID
        self.email = email
        self.password = password
        self.userID = userID
    }
}

