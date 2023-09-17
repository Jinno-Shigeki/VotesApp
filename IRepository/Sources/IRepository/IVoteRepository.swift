//
//  File.swift
//  
//
//  Created by 神野成紀 on 2023/09/17.
//

import Foundation
import Profile
import Vote

public protocol IVoteRepository {
    func createVote(ownerProfileBase: ProfileBase, voteProfileBase: ProfileBase, question: String) async throws
    func getVoteHistory(userID: String) async throws -> [Vote]
}
