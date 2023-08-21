//
//  ProfileCreater.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/01.
//

import Foundation

final class ProfileEditor: ObservableObject, IProfileBase {
    @Published var id: String
    @Published var name: String
    @Published var image: String
    @Published var message: String
    
    init(id: String, name: String, message: String, iconImageString: String) {
        self.id = id
        self.name = name
        self.message = message
        self.image = iconImageString
    }
    
    convenience init() {
        self.init(id: "", name: "", message: "", iconImageString: "")
    }
 }
