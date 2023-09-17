//
//  FriendListInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation
import Profile
import IRepository

@MainActor
final class FollowListInteractor: ObservableObject {
    let profileRepository: IProfileRepository
    @Published var followingProfiles: [ProfileBase] = [ProfileBase(userID: "", displayID: "", name: "", image: Data())]
    
    init(profileRepository: IProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    func listFollowingProfiles() {
        let userID = LocalSave.getStr(.userID)
        Task {
            do {
                followingProfiles = try await profileRepository.getFollowingProfiles(userID: userID)
            } catch {
                
            }
        }
    }
}
