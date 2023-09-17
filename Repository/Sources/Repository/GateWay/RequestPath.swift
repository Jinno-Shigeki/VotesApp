//
//  RequestPath.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/06.
//

import Foundation

enum Path {
    case account(accountID: String)
    case profile(userID: String)
    case following(userID: String, followingUserID: String)
    case follower(userID: String, followingUserID: String)
}

enum ListPath {
    case followings(userID: String)
    case followers(userID: String)
    case voteHistory(userID: String)
}

enum WithQuery {
    case account(email: String, pass: String)
    case profiles(param: String)
}
