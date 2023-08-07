//
//  Converter.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/26.
//

import CryptoKit
import Foundation

struct Converter {
    static func ConvertHashFromID(userID: String) -> String {
        let data = userID.data(using: .utf8)
        let hash = SHA256.hash(data: data!)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
