//
//  FollowEditor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import Foundation

final class FollowEditor: ObservableObject {
    @Published var isFollowing = false
    let profile: any ProfileBase
    
    init(base: any ProfileBase, isFollowing: Bool = false) {
        self.isFollowing = isFollowing
        self.profile = base
    }
}
