//
//  File.swift
//  
//
//  Created by 神野成紀 on 2023/09/17.
//

import Foundation
import Profile

public protocol IFollowRepository {
    func createFollow(owner: ProfileBase, following: ProfileBase) async throws
    func removeFollow(ownerID: String, followingID: String) async throws
}
