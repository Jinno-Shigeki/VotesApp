//
//  UserRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/19.
//

import Foundation

protocol IProfileRepository {
    func getProfile(userID: String) async throws -> Profile
    func getProfiles(param: String) async throws -> [OtherProfile]
    
    func createProfile(accountID: String, profile: ProfileEditor) async throws
}

struct ProfileRepository: IProfileRepository {
    private let fireStoreGateway: IFireStoreGateway
    
    init(fireStoreGateway: IFireStoreGateway) {
        self.fireStoreGateway = fireStoreGateway
    }
    
    let cache = NSCache<NSString, ProfileCache>()
    
    func getProfile(userID: String) async throws -> Profile {
//        if let data = cache[NSString(string: userID)] {
//            return data
//        }
        let profile = try await fireStoreGateway.getProfile(userID: userID)
//        cache[NSString(string: userID)] = ProfileCache(profile: profile)
        return profile
    }
    
    func getProfiles(param: String) async throws -> [OtherProfile] {
        let profiles: [ProfileData] = try await fireStoreGateway.getListWithQuery(.profiles(param: param))
        return profiles.map { data in OtherProfile(id: data.id, name: data.name, image: data.image) }
    }
    
    func createProfile(accountID: String, profile: ProfileEditor) async throws {
        let account = try KeyChainService.shared.getAccount(accountID: accountID)
        let profileData = ProfileData(
            id: profile.id,
            name: profile.name,
            message: profile.message,
            image: profile.image)
        let accountData = AccountData(email: account.email, password: account.password, userID: profile.id)
        try await fireStoreGateway.createProfile(accountID: account.accountID, account: accountData, profile: profileData)
//        cache[NSString(string: profile.id)] = ProfileCache(profile: profile)
    }
}

final class ProfileCache {
    let profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
}

extension NSCache where KeyType == NSString, ObjectType == ProfileCache {
    subscript(_ path: NSString) -> ProfileCache? {
        get {
            return object(forKey: path)
        }
        set {
            if let newValue {
                setObject(newValue, forKey: path)
            } else {
                removeObject(forKey: path)
            }
        }
    }
}


