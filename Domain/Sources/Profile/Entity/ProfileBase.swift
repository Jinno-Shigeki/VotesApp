//
//  File.swift
//  
//
//  Created by 神野成紀 on 2023/09/16.
//

import Foundation

public struct ProfileBase: Hashable {
    public let userID: String
    public let displayID: String
    public let name: String
    public let image: Data
    
    public init(userID: String, displayID: String, name: String, image: Data) {
        self.userID = userID
        self.displayID = displayID
        self.name = name
        self.image = image
    }
}
