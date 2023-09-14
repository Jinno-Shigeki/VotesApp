//
//  FollowProfileData.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/22.
//

import Foundation

public struct FollowingProfileData: Codable {
    public let id: String
    public let name: String
    public let image: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case image
    }
    
    public init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
