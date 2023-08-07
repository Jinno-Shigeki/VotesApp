//
//  VotesData.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/23.
//

import Foundation

struct VoteData: Codable {
    let id: String
    let name: String
    let image: String
    let question: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case image
        case question
        case createdAt = "created_at"
    }
    
    init(id: String, name: String, image: String, question: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.image = image
        self.question = question
        self.createdAt = createdAt
    }
}
