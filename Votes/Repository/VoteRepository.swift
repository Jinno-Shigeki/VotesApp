////
////  VoteRepository.swift
////  Votes
////
////  Created by 神野成紀 on 2023/05/19.
////
//
//import Foundation
//import Profile
//import Vote
//
//protocol IVoteRepository {
//    func createVote(ownerProfileBase: IProfileBase, voteProfileBase: IProfileBase, question: String) async throws
//    func getVoteHistory(userID: String) async throws -> [Vote]
//}
//
//struct VoteRepository: IVoteRepository {
//    private let fireStoreGateway: IFireStoreGateway
//    
//    init(fireStoreGateway: IFireStoreGateway) {
//        self.fireStoreGateway = fireStoreGateway
//    }
//    
//    func createVote(ownerProfileBase: IProfileBase, voteProfileBase: IProfileBase, question: String) async throws {
//        let ownerVoteData = convertVote(profileBase: ownerProfileBase, question: question)
//        let votedData = convertVote(profileBase: voteProfileBase, question: question)
//        try await fireStoreGateway.createVote(ownerVote: votedData, followVote: ownerVoteData)
//    }
//    
//    func getVoteHistory(userID: String) async throws -> [Vote] {
//        let votes: [VoteData] = try await fireStoreGateway.getList(ListPath.voteHistory(userID: userID))
//        return votes.map { data in
//            convertVoteData(voteData: data)
//        }
//    }
//}
//
//extension VoteRepository {
//    func convertVote(profileBase: IProfileBase, question: String) -> VoteData {
//        return VoteData(
//            id: profileBase.id,
//            name: profileBase.name,
//            image: profileBase.image,
//            question: question,
//            createdAt: Date())
//    }
//    
//    func convertVoteData(voteData: VoteData) -> Vote {
//        return Vote(id: voteData.id,
//                    name: voteData.name,
//                    image: voteData.image,
//                    question: voteData.question,
//                    createdAt: voteData.createdAt)
//    }
//}
