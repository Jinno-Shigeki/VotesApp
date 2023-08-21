//
//  ProfileCellContext.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/23.
//

import Foundation

struct ProfileCellContext {
    let isButton: Bool
}

enum ProfileCellContextKey {
    case vote
    case search
}

extension ProfileCellContextKey {
    var content: ProfileCellContext {
        switch self {
        case .vote:
            return ProfileCellContext(isButton: true)
        case .search:
            return ProfileCellContext(isButton: false)
        }
    }
}
