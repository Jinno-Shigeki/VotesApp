//
//  VotesData.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/23.
//

import Foundation

public struct VoteData: Codable {
    public let id: String
    public let name: String
    public let image: String
    public let question: String
    public let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case image
        case question
        case createdAt = "created_at"
    }
    
    public init(id: String, name: String, image: String, question: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.image = image
        self.question = question
        self.createdAt = createdAt
    }
}
