//
//  Auth.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 10/07/22.
//

import Foundation

class Auth: ObservableObject{
    
    public func login(email: String, password: String) async throws -> (Data, HTTPURLResponse?) {
        
        guard let url = URL(string: "\(Constants.BASE_URL)/auth/login") else {
            throw NetworkError.InvalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: [ "email": email, "password": password ], options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let r = response as? HTTPURLResponse
        return (data, r)
        
    }
    
    public func fetchUser() async throws -> User? {
        
        let auth = UserDefaults.standard.string(forKey: "auth_token")
        let refresh = UserDefaults.standard.string(forKey: "refresh_token")
        
        if let refresh = refresh, let auth = auth {
        
            do {
                
                var request = try Utils.buildAuthRequest(for: "auth/user", auth_token: auth, refresh_token: refresh)
                request.httpMethod = "GET"
                
                let (data, response) = try await URLSession.shared.data(for: request)
                print(response)
                return try JSONDecoder().decode(FetchUserResponse.self, from: data).result
                
            }catch{
                return nil
            }
        
        }else{
            return nil
        }
        
    }
    
    public func isLogged() async throws -> Bool {
        
        let auth = UserDefaults.standard.string(forKey: "auth_token")
        let refresh = UserDefaults.standard.string(forKey: "refresh_token")
        
        if let refresh = refresh, let auth = auth {
        
            do {
                
                var request = try Utils.buildAuthRequest(for: "auth/user", auth_token: auth, refresh_token: refresh)
                request.httpMethod = "GET"
                
                let (_, r) = try await URLSession.shared.data(for: request)
                let status_code = (r as! HTTPURLResponse).statusCode
                
                return status_code == 200
                
            }catch{
                return false
            }
        
        }else{
            return false
        }
        
    }
    
}
