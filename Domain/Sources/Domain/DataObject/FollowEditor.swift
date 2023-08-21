//
//  FollowEditor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import Foundation

final class FollowEditor: ObservableObject {
    @Published var isFollowing = false
    let profile: any IProfileBase
    
    init(base: any IProfileBase, isFollowing: Bool = false) {
        self.isFollowing = isFollowing
        self.profile = base
    }
}
