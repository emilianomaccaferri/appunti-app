//
//  TextInput.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 04/07/22.
//

import SwiftUI

struct TextInput: View {
    
    let placeholder: String
    var type: String = ""
    @FocusState private var focused: Bool
    @Binding<String> var target: String
    
    @ViewBuilder func makeInput() -> some View {
        if type == "password"{
            SecureField("", text: self.$target)
        }else{
            TextField("", text: self.$target)
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading){
            makeInput()
                .frame(height: 55)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .foregroundColor(Color("white"))
                .focused($focused)
            if self.target == "" {
                Text(self.placeholder)
                    .padding(.leading, 10)
                    .foregroundColor(Color("white").opacity(0.3))
                    .onTapGesture {
                        self.focused = true
                    }
            }
        }.onTapGesture {
            self.focused = true
        }
    }
}

