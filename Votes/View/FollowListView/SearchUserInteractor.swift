//
//  SearchUserInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import Foundation
import Profile
import IRepository

@MainActor
final class SearchUserInteractor: ObservableObject {
    let profileRepository: IProfileRepository
    @Published var profiles: [ProfileBase] = [ProfileBase(userID: "", displayID: "", name: "", image: Data())]
    
    init(profileRepository: IProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    func searchProfiles(param: String) {
        Task {
            do {
                profiles = try await profileRepository.getProfileBases(param: param)
            } catch {
                print(error)
            }
        }
    }
}
