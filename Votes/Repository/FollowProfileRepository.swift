//
//  FollowProfileRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/05.
//

import Foundation
import Profile

protocol IFollowProfileRepository {
    func getFollowerProfiles(userID: String) async throws -> [FollowerProfile]
    func getFollowingProfiles(userID: String) async throws -> [FollowingProfile]
}

struct FollowProfileRepository: IFollowProfileRepository {
    private let fireStoreGateway: IFireStoreGateway
    
    init(fireStoreGateway: IFireStoreGateway) {
        self.fireStoreGateway = fireStoreGateway
    }
    
    let profileCollectionKey: String = "Profiles"
    let followsCollectionKey: String = "Follows"
    let followersCollectionKey: String = "Followers"
    
    func getFollowerProfiles(userID: String) async throws -> [FollowerProfile] {
        let profiles: [FollowerProfileData] = try await fireStoreGateway.getList(.followers(userID: userID))
        return profiles.map { data in FollowerProfile(id: data.id, name: data.name, image: data.image) }
    }
    
    func getFollowingProfiles(userID: String) async throws -> [FollowingProfile] {
        let profiles: [FollowingProfileData] = try await fireStoreGateway.getList(.followings(userID: userID))
        return profiles.map { data in FollowingProfile(id: data.id, name: data.name, image: data.image) }
    }
}
