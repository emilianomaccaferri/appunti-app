//
//  Api.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 10/07/22.
//

import Foundation

class Api: ObservableObject{
    
    enum UserState {
        case checking
        case logged
        case not_logged
    }
    
    @Published var auth = Auth()
    @Published var users = Users()
    @Published var logged_in: UserState = .checking
    @Published var user: User? = nil
    
}

enum NetworkError: Error {
    case InvalidURL
    case GenericError
}
