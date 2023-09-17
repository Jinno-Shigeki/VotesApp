//
//  ProfileBase.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/06.
//

import Foundation

public protocol IProfileBase {
    var id: String { get }
    var name: String { get }
    var image: String { get }
}

