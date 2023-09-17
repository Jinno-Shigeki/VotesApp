//
//  Account.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/15.
//

import Foundation

public struct LoginData: Codable {
    public let userID: String
    public let email: String
    public let password: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case password
    }
    
    public init(userID: String, email: String, password: String) {
        self.userID = userID
        self.email = email
        self.password = password
    }
}

