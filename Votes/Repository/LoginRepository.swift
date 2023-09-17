////
////  AccountRepository.swift
////  Votes
////
////  Created by 神野成紀 on 2023/05/15.
////
//
//import Foundation
//import Login
//
//protocol ILoginRepository {
//    func createLogin(userID: String, email: String, pass: String) async throws
//    func getLogin(email: String, pass: String) async throws -> Login
//    func updateLogin(login: Login) async throws
//}
//
//struct LoginRepository: ILoginRepository {
//    private let fireStoreGateway: IFireStoreGateway
//    
//    init(fireStoreGateway: IFireStoreGateway) {
//        self.fireStoreGateway = fireStoreGateway
//    }
//    
//    func createLogin(userID: String, email: String, pass: String) async throws {
//        let data = LoginData(userID: userID, email: email, password: pass)
//        try await fireStoreGateway.create(.account(accountID: userID), data)
//        
//        let entry = Login(userID: userID, email: email, password: pass)
//    }
//    
//    func getLogin(email: String, pass: String) async throws -> Login {
//        let logins: [LoginData] = try await fireStoreGateway.getListWithQuery(.account(email: email, pass: pass))
//        guard let doc = logins.first else {
//            throw NSError(domain: "not found", code: 5)
//        }
//        let data = Login(userID: doc.userID, email: doc.email, password: doc.password)
//        return data
//    }
//    
//    func updateLogin(login: Login) async throws {
//        try await fireStoreGateway.create(.account(accountID: login.userID), login)
//    }
//}

