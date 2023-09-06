//
//  ProfileEditInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation
import Profile

@MainActor
final class ProfileRegisterInteractor: ObservableObject {
    private let profileRepository: IProfileRepository
    private var task: Task<Void, Never>?
    
    init(profileRepository: IProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    deinit {
        task?.cancel()
    }

    func registerProfile(editor: ProfileEditor, complition: @escaping () -> Void) {
        task = Task { [unowned self] in
            do {
                let accountID = LocalSave.getStr(.accountID)
                try await profileRepository.createProfile(accountID: accountID, profile: editor)
                LocalSave.setStr(editor.id, .userID)
                complition()
            } catch {
                
            }
        }
    }
}

