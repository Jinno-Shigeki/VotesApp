//
//  FollowRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/23.
//

import Foundation
import IRepository
import Profile

public struct FollowRepository: IFollowRepository {
    private let fireStore: IFireStore
    
    var followCollectionKey: String { get { return "Follows"} }
    var followingCollectionKey: String { get { return "Followings"} }
    var followerCollectionKey: String { get { return "Followers" } }
    
    public init(fireStore: IFireStore) {
        self.fireStore = fireStore
    }
    
    public func createFollow(owner: ProfileBase, following: ProfileBase) async throws {
        let ownerImage = owner.image.base64EncodedString()
        let followingImage = owner.image.base64EncodedString()
        
        let ownerData = ProfileBaseData(userID: owner.userID, displayID: owner.displayID, name: owner.name, image: ownerImage)
        let followingData = ProfileBaseData(userID: following.userID, displayID: following.displayID, name: following.name, image: followingImage)
        
        let batch = fireStore.db.batch()
        try batch.setData(from: ownerData,
                          forDocument: fireStore.db.collection(followCollectionKey).document(following.userID).collection(followerCollectionKey).document(owner.userID))
        try batch.setData(from: followingData,
                          forDocument: fireStore.db.collection(followCollectionKey).document(owner.userID).collection(followingCollectionKey).document(following.userID))
        try await batch.commit()
    }
    
    public func removeFollow(ownerID: String, followingID: String) async throws {
        let batch = fireStore.db.batch()
        batch.deleteDocument(fireStore.db.collection(followCollectionKey)
            .document(ownerID).collection(followingCollectionKey).document(followingID))
        batch.deleteDocument(fireStore.db.collection(followCollectionKey)
            .document(ownerID).collection(followingCollectionKey).document(followingID))
        try await batch.commit()
    }
}
