//
//  SignUpInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation
import IRepository

@MainActor
final class SignUpInteractor: ObservableObject {
    let loginRepository: ILoginRepository
    
    init(loginRepository: ILoginRepository) {
        self.loginRepository = loginRepository
    }
    
    func signUp(email: String, pass: String) async {
        do {
            try await loginRepository.createLogin(email: email, pass: pass)
        } catch {
            
        }
    }
}
