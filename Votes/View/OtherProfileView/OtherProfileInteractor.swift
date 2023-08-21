//
//  UserProfileInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation
import Profile

@MainActor
final class OtherProfileInteractor: Interactor {
    private let profileRepository: IProfileRepository
    private let followRepository: IFollowRepository
    @Published var profile = Profile(id: "", name: "", image: "", message: "", following: 0, follower: 0, votes: 0)
    
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
                let wrapper = ErrorWrapper(error: error)
                alertObject = AlertObject(errorCode: wrapper.errprCode, message: wrapper.message)
                alertObject.isAlert = true
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
                let owner = FollowerProfile(id: ownerProfile.id, name: ownerProfile.name, image: ownerProfile.image)
                let following = FollowingProfile(id: profile.id, name: profile.name, image: profile.image)
                try await followRepository.createFollow(owner: owner, following: following)
            } catch {

            }
        }
    }
    
    private func removeFollowing() {
        Task {
            do {
                let userID = LocalSave.getStr(.userID)
                try await followRepository.removeFollow(ownerID: userID, followingID: profile.id)
            } catch {

            }
        }
    }
}
