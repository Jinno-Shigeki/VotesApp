//
//  ErrorWrapper.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/18.
//

import Foundation

struct ErrorWrapper {
    let error: NSError
    var isAlert = false
    var errprCode: Int {
        get {
            return error.code
        }
    }
    var message: String {
        get {
            return setMessage()
        }
    }
    
    init(error: Error) {
        self.error = error as NSError
    }
    
    func setMessage() -> String {
        switch errprCode {
        case 4:
            return "操作が完了する前に期限が切れました。"
        case 5:
            return "要求されたドキュメントが見つかりませんでした。"
        default:
            return "不明なエラーが発生しました。"
        }
    }
    
    mutating func active() {
        isAlert = true
    }
    
    mutating func inactive() {
        isAlert = false
    }
}
