//
//  ButtonExample.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

struct ButtonExample: View {
    var body: some View {
        //boton simple
        Button("Boton simple") {
            // resultado se vera en la consola
            print("Holiwi")
        }
        // boton mas completo
        Button(action: {print("holiwi grande")}, label: {
            Text("Boton completo")
                // tamaño
                .frame(width: 150, height: 50)
                // forma
                .foregroundColor(.white)
                .background(.blue)
                //borde del boton
                .cornerRadius(23)
        })
    }
}

struct Counter:View {
    // estado inicial
    @State var subscribersNumber = 0
    var body: some View {
        // funcion de incrementar
        Button(action: {
            subscribersNumber += 1
        }, label: {
            // diseño de estado
            Text("Suscriptores: \(subscribersNumber)")
                .bold()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(height: 50)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(10)
        })
    }
}

#Preview {
    //estructura por orden
    ButtonExample()
    Counter()
}
