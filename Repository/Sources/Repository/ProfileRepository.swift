//
//  UserRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/19.
//

import Foundation
import IRepository
import Profile

public struct ProfileRepository: IProfileRepository {
    private let fireStore: IFireStore
    var profileCollectionKey: String { get { return "Profiles" } }
    var followCollectionKey: String { get { return "Follows"} }
    var followingCollectionKey: String { get { return "Followings"} }
    var followerCollectionKey: String { get { return "Followers" } }
    var votesCollectionKey: String { get { return "Votes" } }
    var ownerVotesCollectionKey: String { get { return "OwnerVotes" } }
    var followVotesCollectionKey: String { get { return "FollowVotes" } }
    
    public init(fireStore: IFireStore) {
        self.fireStore = fireStore
    }
    
    let cache = NSCache<NSString, ProfileCache>()
    
    public func getProfile(userID: String) async throws -> Profile {
        var profileData: ProfileData?
        var followingCount: Int?
        var followerCount: Int?
        var voteCount: Int?
        try await withThrowingTaskGroup(of: GetProfileResult.self, body: { group in
            group.addTask {
                try Task.checkCancellation()
                let data = try await fireStore.db.collection(profileCollectionKey)
                    .document(userID).getDocument(as: ProfileData.self)
                return .profileData(data: data)
            }
            group.addTask {
                try Task.checkCancellation()
                // フォロー数取得
                let followingCount = try await fireStore.db.collection(followCollectionKey)
                    .document(userID).collection(followingCollectionKey).count
                    .getAggregation(source: .server).count.intValue
                return .followingCount(count: followingCount)
            }
            group.addTask {
                try Task.checkCancellation()
                // フォロワー数取得
                let followerCount = try await fireStore.db.collection(followCollectionKey)
                    .document(userID).collection(followerCollectionKey).count
                    .getAggregation(source: .server).count.intValue
                return .followerCount(count: followerCount)
            }
            group.addTask {
                try Task.checkCancellation()
                // 投票数取得
                let voteCount = try await fireStore.db.collection(votesCollectionKey)
                    .document(userID).collection(ownerVotesCollectionKey).count
                    .getAggregation(source: .server).count.intValue
                return .voteCount(count: voteCount)
            }
            
            for try await result in group {
                switch result {
                case .profileData(data: let data):
                    profileData = data
                case .followerCount(count: let count):
                    followerCount = count
                case .followingCount(count: let count):
                    followingCount = count
                case .voteCount(count: let count):
                    voteCount = count
                }
            }
        })
        guard let profileData, let followerCount, let followingCount, let voteCount else {
            throw NSError()
        }
        guard let image = Data(base64Encoded: profileData.image) else {
            throw NSError()
        }
        return Profile(userID: profileData.userID, displayID: profileData.displayID, name: profileData.name, image: image, message: profileData.message, following: followingCount, follower: followerCount, votes: voteCount)
    }
    
    public func getProfileBases(param: String) async throws -> [ProfileBase] {
        let snaps = try await fireStore.db.collection(profileCollectionKey)
            .whereFilter(.orFilter([.whereField("display_id", isEqualTo: param),.whereField("name", isEqualTo: param)]))
            .getDocuments()
            .documents
        let datas = try snaps.map { snap in try snap.data(as: ProfileData.self) }
        let bases = try datas.map { data in
            guard let image = Data(base64Encoded: data.image) else { throw NSError() }
            return ProfileBase(userID: data.userID, displayID: data.displayID, name: data.name, image: image)
        }
        return bases
    }
    
    public func createProfile(userID: String, profile: ProfileEditor) async throws {
        let image = profile.image.base64EncodedString()
        let profileData = ProfileData(userID: userID, displayID: profile.displayID, name: profile.name, message: profile.message, image: image)
        try fireStore.db.collection(profileCollectionKey).document(userID).setData(from: profileData.self)
    }
    
    public func getFollowerProfiles(userID: String) async throws -> [ProfileBase] {
        let snaps = try await fireStore.db.collection(followCollectionKey)
            .document(userID)
            .collection(followerCollectionKey)
            .getDocuments().documents
        
        let followers = try snaps.map{ snap in try snap.data(as: ProfileBaseData.self) }
        return try followers.map { data in try convertProfileBaseData(data: data) }
    }
    
    public func getFollowingProfiles(userID: String) async throws -> [ProfileBase] {
        let snaps = try await fireStore.db.collection(followCollectionKey)
            .document(userID)
            .collection(followingCollectionKey)
            .getDocuments().documents
        
        let followers = try snaps.map{ snap in try snap.data(as: ProfileBaseData.self) }
        return try followers.map { data in try convertProfileBaseData(data: data) }
    }
}

extension ProfileRepository {
    private enum GetProfileResult {
        case profileData(data: ProfileData)
        case followingCount(count: Int)
        case followerCount(count: Int)
        case voteCount(count: Int)
    }
    
    private func convertProfileBaseData(data: ProfileBaseData) throws -> ProfileBase {
        let imageData = Data(base64Encoded: data.image)
        guard let imageData else { throw NSError() }
        return ProfileBase(userID: data.userID, displayID: data.displayID, name: data.name, image: imageData)
    }
}

final class ProfileCache {
    let profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
}

extension NSCache where KeyType == NSString, ObjectType == ProfileCache {
    subscript(_ path: NSString) -> ProfileCache? {
        get {
            return object(forKey: path)
        }
        set {
            if let newValue {
                setObject(newValue, forKey: path)
            } else {
                removeObject(forKey: path)
            }
        }
    }
}


