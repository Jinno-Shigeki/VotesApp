//
//  UserProfileInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation
import Profile
import IRepository

@MainActor
final class OtherProfileInteractor: ObservableObject {
    private let profileRepository: IProfileRepository
    private let followRepository: IFollowRepository
    @Published var profile = Profile(userID: "", displayID: "", name: "", image: Data(), message: "", following: 0, follower: 0, votes: 0)
    
    init(profileRepository: IProfileRepository, followRepository: IFollowRepository) {
        self.profileRepository = profileRepository
        self.followRepository = followRepository
    }
    
    func getUserProfile(userID: String) {
        if userID == "" {
            return
        }
        Task {
            do {
                profile = try await profileRepository.getProfile(userID: userID)
            } catch {
                
            }
        }
    }
    
    func updateFollowState(isFollowing: Bool, nowFollowState: Bool) {
        if isFollowing == nowFollowState {
            return
        }
        if isFollowing {
            following()
            return
        }
        removeFollowing()
    }
    
    private func following() {
        Task {
            do {
                let userID = LocalSave.getStr(.userID)
                let ownerProfile = try await profileRepository.getProfile(userID: userID)
                let owner = ProfileBase(userID: userID, displayID: ownerProfile.displayID, name: ownerProfile.name, image: ownerProfile.image)
                let following = ProfileBase(userID: profile.userID, displayID: profile.displayID, name: profile.name, image: profile.image)
                try await followRepository.createFollow(owner: owner, following: following)
            } catch {

            }
        }
    }
    
    private func removeFollowing() {
        Task {
            do {
                let userID = LocalSave.getStr(.userID)
                try await followRepository.removeFollow(ownerID: userID, followingID: profile.userID)
            } catch {

            }
        }
    }
}
