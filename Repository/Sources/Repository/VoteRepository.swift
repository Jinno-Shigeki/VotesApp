//
//  VoteRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/19.
//

import Foundation
import IRepository
import Profile
import Vote

public struct VoteRepository: IVoteRepository {
    private let fireStore: IFireStore
    
    var votesCollectionKey: String { get { return "Votes" } }
    var ownerVotesCollectionKey: String { get { return "OwnerVotes" } }
    var followVotesCollectionKey: String { get { return "FollowVotes" } }
    
    public init(fireStore: IFireStore) {
        self.fireStore = fireStore
    }
    
    public func createVote(ownerProfileBase: ProfileBase, voteProfileBase: ProfileBase, question: String) async throws {
        let ownerVoteData = convertVote(profileBase: ownerProfileBase, question: question)
        let votedData = convertVote(profileBase: voteProfileBase, question: question)
        let batch = fireStore.db.batch()
        
        try batch.setData(from: ownerVoteData,
                          forDocument: fireStore.db.collection(votesCollectionKey)
            .document(ownerVoteData.userID)
            .collection(ownerVotesCollectionKey).document())
        
        try batch.setData(from: votedData,
                          forDocument: fireStore.db.collection(votesCollectionKey)
            .document(votedData.userID)
            .collection(followVotesCollectionKey).document())
        try await batch.commit()
    }
    
    public func getVoteHistory(userID: String) async throws -> [Vote] {
        let snaps = try await fireStore.db.collection(votesCollectionKey)
            .document(userID)
            .collection(ownerVotesCollectionKey)
            .getDocuments().documents
        
        let votesData = try snaps.map{snap in try snap.data(as: VoteData.self)}
        return try votesData.map{data in try convertVoteData(voteData: data)}
    }
}

extension VoteRepository {
    func convertVote(profileBase: ProfileBase, question: String) -> VoteData {
        return VoteData(userID: profileBase.userID,
                        displayID: profileBase.displayID,
                        name: profileBase.name,
                        image: profileBase.image.base64EncodedString(),
                        question: question,
                        createdAt: Date())
    }
    
    func convertVoteData(voteData: VoteData) throws -> Vote {
        let imageData = Data(base64Encoded: voteData.image)
        guard let imageData else {
            throw NSError()
        }
        return Vote(userID: voteData.userID,
                    displayID: voteData.displayID,
                    name: voteData.name,
                    image: imageData,
                    question: voteData.question,
                    createdAt: voteData.createdAt)
    }
}
