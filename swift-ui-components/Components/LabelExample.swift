//
//  LabelExample.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

struct LabelExample: View {
    var body: some View {
        //tamaño con texto
        Label("SUSCRIBETE", image: "swift")
        // icono con texto
        Label("SUSCRIBETE", systemImage: "figure.badminton")
        // imagen con texto en el mismo tamaño junto como texto
        Label(
            title: { /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/ },
            icon: { Image("swift")
                    .resizable()
                    .scaledToFit()
                .frame(height: 30) }
        )
    }
}

#Preview {
    LabelExample()
}
