//
//  FollowProfileRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/05.
//

//import Foundation
//import Profile
//
//protocol IFollowProfileRepository {
//    func getFollowerProfiles(userID: String) async throws -> [ProfileBase]
//    func getFollowingProfiles(userID: String) async throws -> [ProfileBase]
//}
//
//struct FollowProfileRepository: IFollowProfileRepository {
//    private let fireStore: IFireStore
//
//    init(fireStore: IFireStore) {
//        self.fireStore = fireStore
//    }
//
//    let profileCollectionKey: String = "Profiles"
//    let followsCollectionKey: String = "Follows"
//    let followersCollectionKey: String = "Followers"
//
//    func getFollowerProfiles(userID: String) async throws -> [ProfileBase] {
//        let snaps = try await fireStore.db.collection(followsCollectionKey)
//            .document(userID)
//            .collection(followersCollectionKey)
//            .getDocuments().documents
//
//        let followers = try snaps.map{ snap in try snap.data(as: ProfileBaseData.self) }
//        return followers.map { data in ProfileBase(userID: <#T##String#>, displayID: <#T##String#>, name: <#T##String#>, image: <#T##Data#>) }
//    }
//
//    func getFollowingProfiles(userID: String) async throws -> [FollowingProfile] {
//        let profiles: [FollowingProfileData] = try await fireStoreGateway.getList(.followings(userID: userID))
//        return profiles.map { data in FollowingProfile(id: data.id, name: data.name, image: data.image) }
//    }
//}
