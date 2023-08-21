//
//  OtherProfile.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import Foundation

struct OtherProfile: IProfileBase, Hashable {
    let id: String
    let name: String
    let image: String
    
    init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
