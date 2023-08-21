//
//  Profile.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/17.
//

import Foundation

public struct Profile: IProfileBase, Hashable {
    public let id: String
    public let name: String
    public let image: String
    public let message: String
    public let following: Int
    public let follower: Int
    public let votes: Int
    
    public init(id: String, name: String, image: String, message: String, following: Int, follower: Int, votes: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.message = message
        self.following = following
        self.follower = follower
        self.votes = votes
    }
}

enum ProfileCacheleUpdater {
    
}
