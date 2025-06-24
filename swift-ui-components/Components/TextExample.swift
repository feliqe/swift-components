//
//  TextExample.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

struct TextExample: View {
    var body: some View {
        VStack{
            Text("Hello, World!").font(.headline)
            // tipografias
            Text("Custom")
                .font(.system(size: 40, weight: .light, design: .monospaced))
                .italic()
                .bold()
                .underline()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .background(.red)
                .padding()
            // interlineas
            Text("aris aris aris aris aris aris")
                .frame(width: 150)
                .lineLimit(3)
                .lineSpacing(125)
        }
    }
}

#Preview {
    TextExample()
}
