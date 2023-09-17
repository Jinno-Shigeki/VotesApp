//
//  File.swift
//  
//
//  Created by 神野成紀 on 2023/09/17.
//

import Foundation

public struct ProfileBaseData: Codable {
    public let userID: String
    public let displayID: String
    public let name: String
    public let image: String
    
    public init(userID: String, displayID: String, name: String, image: String) {
        self.userID = userID
        self.displayID = displayID
        self.name = name
        self.image = image
    }
}
