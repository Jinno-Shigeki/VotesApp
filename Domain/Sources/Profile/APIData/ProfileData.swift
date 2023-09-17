//
//  ProfileDetails.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/03.
//

import Foundation

public struct ProfileData: Codable {
    public let userID: String
    public let displayID: String
    public let name: String
    public let image: String
    public let message: String
    
    public init(userID: String, displayID: String, name: String, message: String, image: String) {
        self.userID = userID
        self.displayID = displayID
        self.name = name
        self.image = image
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case displayID = "display_id"
        case name
        case image
        case message
    }
}
