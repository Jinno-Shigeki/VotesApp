//
//  Profile.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/17.
//

import Foundation

struct Profile: IProfileBase, Hashable {
    let id: String
    let name: String
    let image: String
    let message: String
    let following: Int
    let follower: Int
    let votes: Int
    
    init(id: String, name: String, image: String, message: String, following: Int, follower: Int, votes: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.message = message
        self.following = following
        self.follower = follower
        self.votes = votes
    }
}
