//
//  Vote.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/24.
//

import Foundation

struct Vote: Hashable {
    let id: String
    let name: String
    let image: String
    let question: String
    let createdAt: Date
    
    init(id: String, name: String, image: String, question: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.image = image
        self.question = question
        self.createdAt = createdAt
    }
}
