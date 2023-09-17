//
//  File.swift
//  
//
//  Created by 神野成紀 on 2023/09/17.
//

import Foundation
import Profile

public protocol IProfileRepository {
    func getProfile(userID: String) async throws -> Profile
    func getProfileBases(param: String) async throws -> [ProfileBase]
    func getFollowerProfiles(userID: String) async throws -> [ProfileBase]
    func getFollowingProfiles(userID: String) async throws -> [ProfileBase]
    
    func createProfile(userID: String, profile: ProfileEditor) async throws
}
