//
//  RepositoryDependency.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation

final class RepositoryDependency {
    private static let fireStoreGateway = FireStoreGateway()
    static let accountRepository = AccountRepository(fireStoreGateway: fireStoreGateway)
    static let profileRepository = ProfileRepository(fireStoreGateway: fireStoreGateway)
    static let followRepository = FollowRepository(fireStoreGateway: fireStoreGateway)
    static let followProfileRepository = FollowProfileRepository(fireStoreGateway: fireStoreGateway)
    static let voteRepository = VoteRepository(fireStoreGateway: fireStoreGateway)
    static let questionRepository = QuestionRepository()
}
