//
//  ImagenExample.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

struct ImagenExample: View {
    var body: some View {
        Image("swift")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 90)
        
        Image(systemName: "figure.walk")
            .resizable()
            .frame(width: 50, height: 90)
    }
}

#Preview {
    ImagenExample()
}
