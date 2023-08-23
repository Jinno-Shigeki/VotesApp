//
//  KeyChainService.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/15.
//

import Foundation
import Entry

final class KeyChainService {
    static let shared = KeyChainService()
    private let serviceName = "VotesService"
    
    private init() {
        
    }
    
    func saveEntry(entry: Entry) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(entry) else {
            debugPrint("keychain error: decode.")
            return
        }
        
        if update(data: data, accountName: entry.userID) {
            return
        }
        create(data: data, accountName: entry.userID)
    }
    
    private func create(data: Data, accountName: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: accountName,
            kSecValueData as String: data as CFData,
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            debugPrint("keychain error: create failure.")
            return
        }
    }
    
    private func update(data: Data, accountName: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: accountName
        ]
        let attributes: [String: Any] = [kSecAttrAccount as String: accountName,
                                         kSecValueData as String: data]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            return false
        }
        guard status == errSecSuccess else {
            debugPrint("keychain error: update failure.")
            return false
        }
        return true
    }
    
    func getEntry(userID: String) throws -> Entry {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: userID,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true,
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            throw NSError(domain: status.description, code: 505)
        }
        guard status == errSecSuccess else {
            throw NSError(domain: status.description, code: 504)
        }
        guard let data = item as? Data else {
            throw NSError(domain: status.description, code: 503)
        }
        let decoder = JSONDecoder()
        guard let entry = try? decoder.decode(Entry.self, from: data) else { throw NSError() }
        return entry
    }
}
