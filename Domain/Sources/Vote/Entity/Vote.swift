//
//  Vote.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/24.
//

import Foundation

public struct Vote: Hashable {
    public let id: String
    public let name: String
    public let image: String
    public let question: String
    public let createdAt: Date
    
    public init(id: String, name: String, image: String, question: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.image = image
        self.question = question
        self.createdAt = createdAt
    }
}
