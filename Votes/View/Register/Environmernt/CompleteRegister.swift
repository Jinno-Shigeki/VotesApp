//
//  CompleteRegister.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/01.
//

import Foundation
import SwiftUI

final class CompleteRegister: ObservableObject {
    @Published var isRegister = false
    
    init() {
        if LocalSave.getStr(.userID).isEmpty {
            self.isRegister = false
        } else {
            self.isRegister = true
        }
    }
    
    func completeRegister() {
        isRegister = true
    }
}

