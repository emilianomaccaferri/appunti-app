//
//  LoginView.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 05/07/22.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var api: Api
    
    @State var alert: Bool = false
    @State var alert_title: String = ""
    @State var alert_message: String = ""
    @State var errored = false
    @State var logging_in = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("blue")
                    .ignoresSafeArea()
                VStack{
                    Group{
                        Text("Effettua il login")
                            .font(.system(size: 40))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("white"))
                            .padding(.bottom, 20)
                        VStack(spacing: 15){
                            Group{
                                TextInput(placeholder: "Email", target: $email)
                                TextInput(placeholder: "Password", type: "password", target: $password)
                            }
                            .modifier(Shake(shakes: self.errored ? 2: 0))
                            .animation(.easeOut, value: self.errored)
                            HStack{
                                Button(){
                                    Task{
                                        
                                        if(self.email.isEmpty || self.password.isEmpty){
                                            return
                                        }
                                        
                                        self.logging_in = true
                                        
                                        do {
                                            
                                            let (data, response) = try await api.auth.login(email: self.email, password: self.password)
                                            if let status = response?.statusCode {
                                                if status == 200{
                                                    if let u_response = response {
                                                        
                                                        let set_cookie = u_response.allHeaderFields["Set-Cookie"] as! String
                                                        let refresh_token = set_cookie.groups(for: "ref_token=(.*);.*;.*;.*;.*;.*;")[0][0]
                                                        let auth_data = try JSONDecoder().decode(LoginResponse.self, from: data)
                                                        
                                                        UserDefaults.standard.set(auth_data.auth_token, forKey: "auth_token")
                                                        UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
                                                        
                                                        guard let user = try await api.auth.fetchUser() else {
                                                            throw NetworkError.GenericError
                                                        }
                                                        
                                                        if let data = try? JSONEncoder().encode(user){
                                                            UserDefaults.standard.set(data, forKey: "user")
                                                        }
                                                        
                                                        api.logged_in = .logged
                                                        api.user = user
                                                        
                                                    }
                                                }
                                                else if status == 401 {
                                                    self.errored.toggle()
                                                }
                                            }
                                            
                                        }catch{
                                            
                                            print(error)
                                            self.alert_title = "Errore generico"
                                            self.alert_message = "Qualcosa è andato storto durante la richiesta..."
                                            self.alert = true
                                            
                                        }
                                        
                                        self.logging_in = false
                                        
                                    }
                                } label: {
                                    Text("Accedi \(Image(systemName: "arrow.forward"))")
                                        .padding()
                                        .frame(maxWidth: 150)
                                        .foregroundColor(Color("blue"))
                                        .background(Color("white"))
                                        .cornerRadius(20)
                                        .opacity(!self.logging_in ? 1 : 0.3)
                                        
                                }.alert(
                                    isPresented: $alert
                                ){
                                    Alert(title: Text(self.alert_title),
                                          message: Text(self.alert_message),
                                          dismissButton: .default(Text("Ok"))
                                    )
                                }
                                Spacer()
                                Text("Password dimenticata?")
                                    .font(.callout)
                                    .foregroundColor(Color("white"))
                                    .underline()
                                    .scaledToFill()
                                    .minimumScaleFactor(0.4)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
            }.padding(.top, -150)
        }
    }
}

/*struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
*/
