//
//  VoteInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/26.
//

import Foundation
import Vote

@MainActor
final class VoteHistoryInteractor: ObservableObject {
    private let voteRepository: IVoteRepository
    private let profileRepository: IProfileRepository
    private let userID = LocalSave.getStr(.userID)
    
    @Published var histories: [Vote] = []
    
    init(voteRepository: IVoteRepository, profileRepository: IProfileRepository) {
        self.voteRepository = voteRepository
        self.profileRepository = profileRepository
    }
    
    func getHistory() {
        Task {
            do {
                histories = try await voteRepository.getVoteHistory(userID: userID)
            } catch {
                print(error)
            }
        }
    }
}
