//
//  ProfileCreater.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/01.
//

import Foundation

public final class ProfileEditor: ObservableObject, IProfileBase {
    @Published public var id: String
    @Published public var name: String
    @Published public var image: String
    @Published public var message: String
    
    public init(id: String, name: String, message: String, iconImageString: String) {
        self.id = id
        self.name = name
        self.message = message
        self.image = iconImageString
    }
    
    public convenience init() {
        self.init(id: "", name: "", message: "", iconImageString: "")
    }
 }
