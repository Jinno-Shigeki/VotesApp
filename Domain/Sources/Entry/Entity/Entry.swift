//
//  Account.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/17.
//

import Foundation

public struct Entry: Codable {
    public let userID: String
    public let userDisplayID: String
    public let email: String
    public let password: String
    
    public init(userID: String, userDisplayID: String, email: String, password: String) {
        self.userID = userID
        self.userDisplayID = userDisplayID
        self.email = email
        self.password = password
    }
    
    public init() {
        self.userID = ""
        self.userDisplayID = ""
        self.email = ""
        self.password = ""
    }
}
