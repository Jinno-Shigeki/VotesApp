//
//  Profile.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/17.
//

import Foundation

public struct Profile: Hashable {
    public let userID: String
    public let displayID: String
    public let name: String
    public let image: Data
    public let message: String
    public let following: Int
    public let follower: Int
    public let votes: Int
    
    public init(userID: String,
                displayID: String,
                name: String,
                image: Data,
                message: String,
                following: Int,
                follower: Int,
                votes: Int) {
        self.userID = userID
        self.displayID = displayID
        self.name = name
        self.image = image
        self.message = message
        self.following = following
        self.follower = follower
        self.votes = votes
    }
}

