//
//  VotesData.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/23.
//

import Foundation

public struct VoteData: Codable {
    public let userID: String
    public let displayID: String
    public let name: String
    public let image: String
    public let question: String
    public let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case displayID = "display_id"
        case name
        case image
        case question
        case createdAt = "created_at"
    }
    
    public init(userID: String, displayID: String, name: String, image: String, question: String, createdAt: Date) {
        self.userID = userID
        self.displayID = displayID
        self.name = name
        self.image = image
        self.question = question
        self.createdAt = createdAt
    }
}
