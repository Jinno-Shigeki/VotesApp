//
//  File.swift
//  
//
//  Created by 神野成紀 on 2023/09/17.
//

import Foundation
import Login

public protocol ILoginRepository {
    func createLogin(email: String, pass: String) async throws
    func getLogin(email: String, pass: String) async throws -> Login
    func updateLogin(login: Login) async throws
}
