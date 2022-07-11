//
//  User.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 11/07/22.
//

import Foundation

struct User: Codable {
    let id: String
    let admin: Int
    let name: String
    let surname: String
    let email: String
    let unimore_id: String
}
