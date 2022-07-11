//
//  Block.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 11/07/22.
//

import SwiftUI

struct Block<Content: View>: View {
    
    var content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content){
        self.content = content
    }
    
    var body: some View {
        VStack(content: content)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(Color("white"))
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
    }
}

/*struct Block_Previews: PreviewProvider {
    static var previews: some View {
        Block()
    }
}
*/
