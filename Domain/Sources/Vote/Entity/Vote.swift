//
//  Vote.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/24.
//

import Foundation

public struct Vote: Hashable {
    public let userID: String
    public let displayID: String
    public let name: String
    public let image: Data
    public let question: String
    public let createdAt: Date
    
    public init(userID: String, displayID: String, name: String, image: Data, question: String, createdAt: Date) {
        self.userID = userID
        self.displayID = displayID
        self.name = name
        self.image = image
        self.question = question
        self.createdAt = createdAt
    }
}
