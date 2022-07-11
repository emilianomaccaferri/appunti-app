//
//  HomeView.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 11/07/22.
//

import SwiftUI

struct MainView: View {
    
    init(){
        
        UITabBar.appearance().barTintColor = UIColor(Color("blue"))

    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("blue")
                    .ignoresSafeArea()
                TabView{
                    Home()
                        .tabItem{
                            Label("Home", systemImage: "house.fill")
                        }
                }.accentColor(Color("white"))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
