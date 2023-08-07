//
//  ProfileBaseViewData.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/24.
//

import Foundation

struct ProfileBaseViewData: Hashable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
