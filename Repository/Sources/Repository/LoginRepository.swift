//
//  AccountRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/15.
//

import Foundation
import IRepository
import Login

public struct LoginRepository: ILoginRepository {
    var fireStore: IFireStore
    var loginCollectionKey: String { get { return "Logins" } }
    
    public init(fireStore: IFireStore) {
        self.fireStore = fireStore
    }

    public func createLogin(email: String, pass: String) async throws {
        let userID = UUID().uuidString
        let data = LoginData(userID: userID, email: email, password: pass)
        try fireStore.db.collection(loginCollectionKey).document(data.userID).setData(from: data)
    }
    
    public func getLogin(email: String, pass: String) async throws -> Login {
        let snaps = try await fireStore.db.collection(loginCollectionKey)
            .whereField("email", isEqualTo: email)
            .whereField("password", isEqualTo: pass)
            .getDocuments().documents
        // email, passwwordは重複不可なので最初のデータのみ取得
        let data = try snaps.map { loginData in return try loginData.data(as: LoginData.self) }
        guard let login = data.first else { throw NSError() }
        
        return Login(userID: login.userID, email: login.email, password: login.password)
    }
    
    public func updateLogin(login: Login) async throws {
        let data = LoginData(userID: login.userID, email: login.email, password: login.password)
        try fireStore.db.collection(loginCollectionKey).document(login.userID).setData(from: data)
    }
}

