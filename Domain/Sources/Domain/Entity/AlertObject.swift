//
//  AlertObject.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/20.
//

import Foundation

struct AlertObject {
    var isAlert = false
    var title: String
    var message: String
    
    init(errorCode: Int, message: String) {
        self.title = "error: errorCode\(errorCode)"
        self.message = message
    }
    
    mutating func active() {
        isAlert = true
    }
    
    mutating func inactive() {
        isAlert = false
    }
}
