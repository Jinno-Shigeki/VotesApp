//
//  SearchUserInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import Foundation
import Profile

@MainActor
final class SearchUserInteractor: ObservableObject {
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
