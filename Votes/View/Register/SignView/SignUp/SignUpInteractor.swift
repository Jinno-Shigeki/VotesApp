//
//  SignUpInteractor.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation

@MainActor
final class SignUpInteractor: Interactor {
    let accountRepository: IAccountRepository
    private var task: Task<Void, Never>?
    
    init(accountRepository: IAccountRepository) {
        self.accountRepository = accountRepository
    }
    
    deinit {
        task?.cancel()
    }
    
    func signUp(email: String, pass: String, completion: @escaping () -> Void) async {
        task = Task { [unowned self] in
            do {
                let accountID = UUID().uuidString
                try await accountRepository.createAccount(accountID: accountID, email: email, pass: pass)
                LocalSave.setStr(accountID, .accountID)
                completion()
            } catch {
                let wrapper = ErrorWrapper(error: error)
                alertObject = AlertObject(errorCode: wrapper.errprCode, message: wrapper.message)
                alertObject.active()
            }
        }
    }
}
