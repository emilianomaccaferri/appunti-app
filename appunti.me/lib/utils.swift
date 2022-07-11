//
//  utils.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 10/07/22.
//

import Foundation
class Utils {
    public static func buildAuthRequest(for url: String, auth_token: String, refresh_token: String) throws -> URLRequest {
        guard let url = URL(string: "\(Constants.BASE_URL)/\(url)") else {
            throw NetworkError.InvalidURL
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(auth_token)", forHTTPHeaderField: "Authorization")
        request.addValue(refresh_token, forHTTPHeaderField: "Cookie")
        return request
    }
}
