//
//  AuthView.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 04/07/22.
//

import SwiftUI

struct AuthView: View {
    
    private enum Routes: Hashable {
        case registration
        case login
    }
    
    @State var email: String = "";
    @State var password: String = "";
    @State private var route: Routes?
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("blue")
                    .ignoresSafeArea()
                VStack{
                    Group{
                        Text("appunti.me")
                            .font(.system(size: 50))
                            .foregroundColor(Color("white"))
                            .fontWeight(.semibold)
                        Text("fatto da studenti, per gli studenti")
                            .font(.headline)
                            .foregroundColor(Color("white"))
                            .padding(.bottom, 20)
                        VStack(spacing: 10){
                            Button(){
                                self.route = .login
                            } label: {
                                Text("Ho già un account")
                                    .padding()
                                    .foregroundColor(Color("blue"))
                                    .background(Color("white"))
                                    .cornerRadius(20)
                            }
                            Button(){
                                self.route = .registration
                            } label: {
                                Text("Non ho un account")
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.white, lineWidth: 2)
                                ).foregroundColor(Color("white"))

                            }
                        }
                        
                        NavigationLink(destination: RegisterView(), tag: Routes.registration, selection: $route){ EmptyView() }
                        NavigationLink(destination: LoginView(), tag: Routes.login, selection: $route){ EmptyView() }
                        
                    }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                }.padding(.top, -100)
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
