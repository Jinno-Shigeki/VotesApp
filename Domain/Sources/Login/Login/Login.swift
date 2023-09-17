//
//  Account.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/17.
//

import Foundation

public struct Login: Codable {
    public let userID: String
    public let email: String
    public let password: String
    
    public init(userID: String, email: String, password: String) {
        self.userID = userID
        self.email = email
        self.password = password
    }
    
    public init() {
        self.userID = ""
        self.email = ""
        self.password = ""
    }
}
