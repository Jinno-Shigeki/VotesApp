//
//  ProfileEditInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation
import IRepository
import Profile

@MainActor
final class ProfileRegisterInteractor: ObservableObject {
    private let profileRepository: IProfileRepository
    
    init(profileRepository: IProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    func registerProfile(editor: ProfileEditor) async {
        do {
            try await profileRepository.createProfile(userID: "", profile: editor)
        } catch {
            
        }
    }
}

