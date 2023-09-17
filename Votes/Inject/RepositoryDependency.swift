//
//  RepositoryDependency.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation
import Repository

final class RepositoryDependency {
    private static let fireStore = FireStore()
    static let loginRepository = LoginRepository(fireStore: fireStore)
    static let profileRepository = ProfileRepository(fireStore: fireStore)
    static let followRepository = FollowRepository(fireStore: fireStore)
    static let voteRepository = VoteRepository(fireStore: fireStore)
    static let questionRepository = QuestionRepository()
}
