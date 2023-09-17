//
//  ProfileCreater.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/01.
//

import Foundation

public final class ProfileEditor: ObservableObject {
    @Published public var displayID: String
    @Published public var name: String
    @Published public var image: Data
    @Published public var message: String
    
    public init(displayID: String, name: String, message: String, iconImage: Data) {
        self.displayID = displayID
        self.name = name
        self.message = message
        self.image = iconImage
    }
    
    public convenience init() {
        self.init(displayID: "", name: "", message: "", iconImage: Data())
    }
 }
