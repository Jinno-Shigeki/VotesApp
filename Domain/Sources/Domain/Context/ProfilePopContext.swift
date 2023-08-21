//
//  ProfilePopContext.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/23.
//

import Foundation

struct ProfilePopContext {
    let title: String
    let message: String
    let confirmStr: String
    let cancelStr: String
}

enum ProfilePopContextKey {
    case profileCreate
    case vote
}

extension ProfilePopContextKey {
    var content: ProfilePopContext {
        switch self {
        case .profileCreate:
            return ProfilePopContext(title: "これで登録しますか？", message: "ユーザーIDはこれ以降変更できません", confirmStr: "登録する", cancelStr: "もどる")
        case .vote:
            return ProfilePopContext(title: "この人に投票する？", message: "", confirmStr: "投票する", cancelStr: "やっぱやめる")
        }
    }
}
