//
//  SignInInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation
import IRepository

@MainActor
final class SignInInteractor: ObservableObject {
    let loginRepository: ILoginRepository
    
    init(loginRepository: ILoginRepository) {
        self.loginRepository = loginRepository
    }
    
    func signIn(email: String, password: String) async {
        do {
            let login = try await loginRepository.getLogin(email: email, pass: password)
            LocalSave.setStr(login.userID, .userID)
        } catch {
            
        }
    }
}
