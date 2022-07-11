//
//  Home.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 11/07/22.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var api: Api
    @State private var an = false
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("white"))]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("white"))]
    }
    
    var body: some View {
        
        ZStack{
            Color("blue")
                .ignoresSafeArea()
            GeometryReader{ gr in
                VStack(alignment: .leading){
                    Group{
                        Text("Ecco un veloce riepilogo")
                            .foregroundColor(Color("white"))
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Group{
                            HStack(alignment: .center, spacing: 10){
                                VStack{
                                    Block {
                                        VStack{
                                            Image(systemName: "gearshape.fill")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("Impostazioni profilo")
                                                .lineLimit(1)
                                                .font(.callout)
                                                .scaledToFill()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .frame(height: 50)
                                    }
                                }.frame(width: (gr.size.width / 2) - 20)
                                VStack{
                                    Block {
                                        VStack{
                                            Image(systemName: "chevron.left.forwardslash.chevron.right")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("Pannello sviluppatore")
                                                .lineLimit(1)
                                                .font(.callout)
                                                .scaledToFill()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .frame(height: 50)
                                    }
                                }.frame(width: (gr.size.width / 2) - 25)
                            }
                            HStack(alignment: .center){
                                Block{
                                    Text("Spazio utilizzato: 1024/2048MB")
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    VStack{
                                        RoundedRectangle(cornerRadius: 100)
                                            .foregroundColor(Color("blue"))
                                            .frame(width: self.an ? (gr.size.width) * 0.5 : 0, height: 10, alignment: .leading)
                                            .animation(.easeInOut, value: self.an)
                                    }.frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }.padding(.top, 10)
                                            
                    }
                    .padding(.leading, 17.5)
                    .padding(.trailing, 17.5)
                    .padding(.top, -5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
            }
        }
        .task {
            // loading logic qua
            self.an = true
        }
        .navigationTitle("Ciao, \(api.user!.name)")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
