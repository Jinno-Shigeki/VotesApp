//
//  VoteViewInteracter.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/23.
//

import Foundation
import Profile

@MainActor
final class VoteInteractor: ObservableObject {
    let voteRepository: IVoteRepository
    let profileRepository: IProfileRepository
    let followProfileRepository: IFollowProfileRepository
    let questionRepository: IQuestionRepository
    @Published var followingProfiles: [FollowingProfile] = [FollowingProfile(id: "", name: "", image: "")]
    private let userID = LocalSave.getStr(.userID)
    
    init(voteRepository: IVoteRepository,
         profileRepository: IProfileRepository,
         followProfileRepository: IFollowProfileRepository,
         questionRepository: IQuestionRepository) {
        self.voteRepository = voteRepository
        self.profileRepository = profileRepository
        self.followProfileRepository = followProfileRepository
        self.questionRepository = questionRepository
    }
    
    func getQuestion() -> String {
        questionRepository.getQuestion()
    }
    
    func getFollowingProfileBases() {
        Task {
            do {
                followingProfiles = try await followProfileRepository.getFollowingProfiles(userID: userID)
            } catch {
                print(error)
            }
        }
    }
    
    func vote(votedProfile: IProfileBase, question: String, complition: @escaping () -> Void) {
        Task {
            do {
                let profile = try await profileRepository.getProfile(userID: userID)
                try await voteRepository.createVote(ownerProfileBase: profile, voteProfileBase: votedProfile, question: question)
                complition()
            } catch {
                print(error)
            }
        }
    }
}
