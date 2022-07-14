//
//  Users.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 14/07/22.
//

import Foundation

class Users: ObservableObject{
    
    public func getSizeInfo() async throws -> SizeInfo? {
        
        let auth = UserDefaults.standard.string(forKey: "auth_token")
        let refresh = UserDefaults.standard.string(forKey: "refresh_token")
        
        if let refresh = refresh, let auth = auth {
        
            do {
                
                var request = try Utils.buildAuthRequest(for: "users/size", auth_token: auth, refresh_token: refresh)
                request.httpMethod = "GET"
                
                let (data, response) = try await URLSession.shared.data(for: request)
                print(response)
                return try JSONDecoder().decode(SizeInfo.self, from: data)
                
            }catch{
                return nil
            }
        
        }else{
            return nil
        }
        
        
    }
    
}
