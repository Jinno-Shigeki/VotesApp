//
//  OtherProfile.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import Foundation

public struct OtherProfile: IProfileBase, Hashable {
    public let id: String
    public let name: String
    public let image: String
    
    public init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
