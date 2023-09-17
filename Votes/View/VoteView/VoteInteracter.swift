//
//  VoteViewInteracter.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/23.
//

import Foundation
import IRepository
import Profile

@MainActor
final class VoteInteractor: ObservableObject {
    let voteRepository: IVoteRepository
    let profileRepository: IProfileRepository
    let questionRepository: IQuestionRepository
    @Published var followingProfiles: [ProfileBase] = [ProfileBase(userID: "", displayID: "", name: "", image: Data())]
    private let userID = LocalSave.getStr(.userID)
    
    init(voteRepository: IVoteRepository,
         profileRepository: IProfileRepository,
         questionRepository: IQuestionRepository) {
        self.voteRepository = voteRepository
        self.profileRepository = profileRepository
        self.questionRepository = questionRepository
    }
    
    func getQuestion() -> String {
        questionRepository.getQuestion()
    }
    
    func getFollowingProfileBases() async {
            do {
                followingProfiles = try await profileRepository.getFollowingProfiles(userID: userID)
            } catch {
                print(error)
            }
    }
    
    func vote(votedProfile: ProfileBase, question: String) async {
        do {
            let profile = try await profileRepository.getProfile(userID: userID)
            let profireBase = ProfileBase(userID: profile.userID, displayID: profile.displayID, name: profile.name, image: profile.image)
            try await voteRepository.createVote(ownerProfileBase: profireBase, voteProfileBase: votedProfile, question: question)
        } catch {
            print(error)
        }
    }
}
