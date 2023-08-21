//
//  ProfileDetails.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/03.
//

import Foundation

struct ProfileData: Codable {
    let id: String
    let name: String
    let image: String
    let message: String
    
    init(id: String, name: String, message: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case message
    }
}
