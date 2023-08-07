//
//  FollowProfileData.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/22.
//

import Foundation

struct FollowingProfileData: Codable {
    let id: String
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case image
    }
    
    init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
