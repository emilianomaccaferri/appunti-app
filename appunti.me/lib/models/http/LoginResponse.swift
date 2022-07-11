//
//  LoginModel.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 10/07/22.
//

import Foundation

struct LoginResponse: Codable {
    let success: Bool
    let auth_token: String
    let refresh_token_expiry: String
}
