//
//  FetchUserResponse.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 11/07/22.
//

import Foundation

struct FetchUserResponse: Codable {
    let success: Bool
    let result: User
}
