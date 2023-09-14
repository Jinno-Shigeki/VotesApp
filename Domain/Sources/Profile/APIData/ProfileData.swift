//
//  ProfileDetails.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/03.
//

import Foundation

public struct ProfileData: Codable {
    public let id: String
    public let name: String
    public let image: String
    public let message: String
    
    public init(id: String, name: String, message: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
        self.message = message
    }
    
    public init(profile: Profile) {
        self.id = profile.id
        self.name = profile.name
        self.image = profile.image
        self.message = profile.message
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case message
    }
}
