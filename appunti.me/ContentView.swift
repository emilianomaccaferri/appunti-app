//
//  ContentView.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 04/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var is_logged = false;
    @StateObject var api = Api()
    var override = false
    var parsed_user: User?
    
    init(){
        // reset defaults
        /*if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }*/
        if let saved_user = UserDefaults.standard.object(forKey: "user") as? Data {
            if let parsed = try? JSONDecoder().decode(User.self, from: saved_user){
                self.parsed_user = parsed
            }
        }else{
            override = true
        }
    }
    
    var body: some View {
        Group{
            if(api.logged_in == .not_logged){
                AuthView()
                    .environmentObject(api)
            }else if api.logged_in == .logged{
                MainView()
                    .environmentObject(api)
            }else{
                Color("blue")
                    .ignoresSafeArea()
            }
        }.task {
            if !override {
                do{
                    api.logged_in = try await api.auth.isLogged() ? .logged : .not_logged
                    if api.logged_in == .logged {
                        api.user = self.parsed_user
                    }
                }catch{
                    api.logged_in = .not_logged
                }
            }else{
                api.logged_in = .not_logged
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
