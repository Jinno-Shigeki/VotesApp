//
//  LocalSave.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/16.
//

import Foundation

final class LocalSave {
    static func getStr(_ key: LocalSaveKey) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    static func setStr(_ str: String, _ key: LocalSaveKey) {
        UserDefaults.standard.set(str, forKey: key.rawValue)
    }
}

enum LocalSaveKey: String {
    case accountID = "account_id"
    case userID = "user_id"
}
