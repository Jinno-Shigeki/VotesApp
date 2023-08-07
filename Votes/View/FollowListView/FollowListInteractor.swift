//
//  FriendListInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation

@MainActor
final class FollowListInteractor: Interactor {
    let followProfileRepository: IFollowProfileRepository
    @Published var followingProfiles: [FollowingProfile] = [FollowingProfile(id: "", name: "", image: "")]
    
    init(followProfileRepository: IFollowProfileRepository) {
        self.followProfileRepository = followProfileRepository
    }
    
//    func listFollowerProfileBases() async {
//        guard let userID = UserDefaults.standard.string(forKey: "") else { return }
//        do {
//            profiles = try await followProfileRepository.getFollowerProfiles(userID: userID)
//        } catch {
//            let wrapper = ErrorWrapper(error: error)
//            alertObject = AlertObject(errorCode: wrapper.errprCode, message: wrapper.message)
//            alertObject.isAlert = true
//        }
//    }
    
    func listFollowingProfiles() {
        let userID = LocalSave.getStr(.userID)
        Task {
            do {
                followingProfiles = try await followProfileRepository.getFollowingProfiles(userID: userID)
            } catch {
                let wrapper = ErrorWrapper(error: error)
                alertObject = AlertObject(errorCode: wrapper.errprCode, message: wrapper.message)
                alertObject.isAlert = true
            }
        }
    }
}
