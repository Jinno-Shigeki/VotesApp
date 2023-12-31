//
//  FollowerProfile.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/22.
//

import Foundation

struct FollowerProfile: ProfileBase, Hashable {
    let id: String
    let name: String
    let image: String
    
    init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
