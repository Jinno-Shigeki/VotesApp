//
//  Account.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/15.
//

import Foundation
import FirebaseFirestoreSwift

struct AccountData: Codable {
    @DocumentID var accountID: String?
    let email: String
    let password: String
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case accountID = "id"
        case email
        case password
        case userID = "user_id"
    }
}

