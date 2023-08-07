//
//  SearchUserInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import Foundation

import Foundation

@MainActor
final class SearchUserInteractor: Interactor {
    let profileRepository: IProfileRepository
    @Published var profiles: [OtherProfile] = [OtherProfile(id: "", name: "", image: "")]
    
    init(profileRepository: IProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    func searchProfiles(param: String) {
        Task {
            do {
                profiles = try await profileRepository.getProfiles(param: param)
            } catch {
                print(error)
            }
        }
    }
}
