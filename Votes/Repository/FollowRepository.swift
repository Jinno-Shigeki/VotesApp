//
//  FollowRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/23.
//

import Foundation

protocol IFollowRepository {
    func createFollow(owner: FollowerProfile, following: FollowingProfile) async throws
    func removeFollow(ownerID: String, followingID: String) async throws
}

struct FollowRepository: IFollowRepository {
    private let fireStoreGateway: IFireStoreGateway
    
    init(fireStoreGateway: IFireStoreGateway) {
        self.fireStoreGateway = fireStoreGateway
    }
    
    func createFollow(owner: FollowerProfile, following: FollowingProfile) async throws {
        let followerData = FollowerProfileData(id: owner.id, name: owner.name, image: owner.image)
        let followingData = FollowingProfileData(id: following.id, name: following.name, image: following.image)
        try await fireStoreGateway.following(owner: followerData, following: followingData)
    }
    
    func removeFollow(ownerID: String, followingID: String) async throws {
        try await fireStoreGateway.removeFollowing(ownerID: ownerID, followingID: followingID)
    }
}
