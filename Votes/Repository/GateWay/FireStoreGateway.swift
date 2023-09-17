////
////  FireStoreGateway.swift
////  Votes
////
////  Created by 神野成紀 on 2023/06/18.
////
//
//import CryptoKit
//import Foundation
//import FirebaseCore
//import FirebaseFirestore
//import Profile
//
//protocol IFireStoreGateway {
//    func create<T: Codable>(_ path: Path, _ data: T) async throws
//    func get<T: Codable>(_ path: Path) async throws -> T
//    func getList<T: Codable>(_ path: ListPath) async throws -> [T]
//    func getListWithQuery<T: Codable>(_ path: WithQuery) async throws -> [T]
//
//    func createProfile(accountID: String, account: AccountData, profile: ProfileData) async throws
//    func following(owner: FollowerProfileData, following: FollowingProfileData) async throws
//    func removeFollowing(ownerID: String, followingID: String) async throws
//    func createVote(ownerVote: VoteData, followVote: VoteData) async throws
//
//    func getProfile(userID: String) async throws -> Profile
//}
//
//struct FireStoreGateway: IFireStoreGateway {
//    let db = Firestore.firestore()
//
//    func create<T: Codable>(_ path: Path, _ data: T) async throws {
//        try convertPath(path: path).setData(from: data)
//    }
//
//    func get<T: Codable>(_ path: Path) async throws -> T {
//        try await convertPath(path: path).getDocument(as: T.self)
//    }
//
//    func getList<T: Codable>(_ path: ListPath) async throws -> [T] {
//        let snaps = try await convertPathList(path: path).getDocuments().documents
//        let ret = try snaps.map { snap in
//            let data = try snap.data(as: T.self)
//            return data
//        }
//        return ret
//    }
//
//    func getListWithQuery<T: Codable>(_ path: WithQuery) async throws -> [T] {
//        let snaps = try await convertQuery(path: path).getDocuments().documents
//        if snaps.isEmpty {
//            return []
//        }
//        let ret = try snaps.map { snap in
//            let data = try snap.data(as: T.self)
//            return data
//        }
//        return ret
//    }
//}
//
//extension FireStoreGateway {
//    func convertHashFromID(id: String) -> String {
//        let data = id.data(using: .utf8)
//        let hash = SHA256.hash(data: data!)
//        return hash.compactMap { String(format: "%02x", $0) }.joined()
//    }
//}
//
//extension FireStoreGateway {
//    var accountCollectionKey: String { get { return "Accounts" } }
//    var profileCollectionKey: String { get { return "Profiles" } }
//    var followCollectionKey: String { get { return "Follows"} }
//    var followingCollectionKey: String { get { return "Followings"} }
//    var followerCollectionKey: String { get { return "Followers" } }
//    var votesCollectionKey: String { get { return "Votes" } }
//    var ownerVotesCollectionKey: String { get { return "OwnerVotes" } }
//    var followVotesCollectionKey: String { get { return "FollowVotes" } }
//
//    func convertPath(path: Path) -> DocumentReference {
//        switch path {
//        case .account(accountID: let id):
//            return db.collection(accountCollectionKey).document(id)
//        case .profile(userID: let id):
//            return db.collection(profileCollectionKey).document(id)
//        case .following(userID: let id, followingUserID: let followingID):
//            return db.collection(followCollectionKey).document(id).collection(followingCollectionKey).document(followingID)
//        case .follower(userID: let id, followingUserID: let followingID):
//            return db.collection(followCollectionKey).document(followingID).collection(followingCollectionKey).document(id)
//        }
//    }
//
//    func convertPathList(path: ListPath) -> CollectionReference {
//        switch path {
//        case .followings(userID: let id):
//            return db.collection(followCollectionKey).document(id).collection(followingCollectionKey)
//        case .followers(userID: let id):
//            return db.collection(followCollectionKey).document(id).collection(followerCollectionKey)
//        case .voteHistory(userID: let userID):
//            return db.collection(votesCollectionKey).document(userID).collection(ownerVotesCollectionKey)
//        }
//    }
//
//    func convertQuery(path: WithQuery) -> Query {
//        switch path {
//        case .account(email: let email, pass: let pass):
//            return db.collection(accountCollectionKey)
//                .whereField("email", isEqualTo: email)
//                .whereField("password", isEqualTo: pass)
//        case .profiles(param: let param):
//            return db.collection(profileCollectionKey)
//                .whereFilter(Filter.orFilter([
//                    Filter.whereField("id", isEqualTo: param),
//                    Filter.whereField("name", isEqualTo: param)]))
//        }
//    }
//}
//
//extension FireStoreGateway {
//    func createProfile(accountID: String, account: AccountData, profile: ProfileData) async throws {
//        let batch = db.batch()
//        try batch.setData(from: account, forDocument: convertPath(path: .account(accountID: accountID)))
//        try batch.setData(from: profile, forDocument: convertPath(path: .profile(userID: profile.id)))
//        batch.setData(["id": profile.id], forDocument: db.collection(followCollectionKey).document(profile.id))
//        try await batch.commit()
//    }
//
//    func following(owner: FollowerProfileData, following: FollowingProfileData) async throws {
//        let batch = db.batch()
//        try batch.setData(
//            from: owner,
//            forDocument: convertPath(path: .follower(userID: owner.id, followingUserID: following.id))
//        )
//        try batch.setData(
//            from: following,
//            forDocument: convertPath(path: .following(userID: owner.id, followingUserID: following.id))
//        )
//        try await batch.commit()
//    }
//
//    func removeFollowing(ownerID: String, followingID: String) async throws {
//        let batch = db.batch()
//        batch.deleteDocument(convertPath(path: .follower(userID: ownerID, followingUserID: followingID)))
//        batch.deleteDocument(convertPath(path: .following(userID: ownerID, followingUserID: followingID)))
//        try await batch.commit()
//    }
//
//    func createVote(ownerVote: VoteData, followVote: VoteData) async throws {
//        let batch = db.batch()
//        let ownerID = followVote.id
//        let followID = ownerVote.id
//        try batch.setData(from: ownerVote,
//                          forDocument: db.collection(votesCollectionKey).document(ownerID).collection(ownerVotesCollectionKey).document())
//        try batch.setData(from: followVote,
//                          forDocument: db.collection(votesCollectionKey).document(followID).collection(followVotesCollectionKey).document())
//        try await batch.commit()
//    }
//
//    func getProfile(userID: String) async throws -> Profile {
//        let data: ProfileData = try await get(.profile(userID: userID))
//        let followingCount = try await db.collection(followCollectionKey).document(userID)
//                                .collection(followingCollectionKey).count.getAggregation(source: .server).count.intValue
//        let followerCount = try await db.collection(followCollectionKey).document(userID)
//                                .collection(followerCollectionKey).count.getAggregation(source: .server).count.intValue
//        let voteCount = try await db.collection(votesCollectionKey).document(userID)
//                        .collection(ownerVotesCollectionKey).count.getAggregation(source: .server).count.intValue
//        return Profile(id: data.id, name: data.name, image: data.image, message: data.message,
//                       following: followingCount, follower: followerCount, votes: voteCount)
//    }
//}
