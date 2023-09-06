//
//  SignInInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation

@MainActor
final class SignInInteractor: ObservableObject {
    let accountRepository: IAccountRepository
    private var task: Task<Void, Never>?
    
    init(accountRepository: IAccountRepository) {
        self.accountRepository = accountRepository
    }
    
    deinit {
        task?.cancel()
    }
    
    func signIn(email: String, password: String, completion: @escaping (_ isUserID: Bool) -> Void) async {
        task = Task { [unowned self] in
            do {
                let account = try await accountRepository.getAccount(email: email, pass: password)
                if account.userID.isEmpty {
                    completion(false)
                    return
                }
                LocalSave.setStr(account.userID, .userID)
                completion(true)
            } catch {
                
            }
        }
    }
}
