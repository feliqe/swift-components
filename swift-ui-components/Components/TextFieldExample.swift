//
//  TextFieldExample.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

struct TextFieldExample: View {
    // estados disponibles
    @State var email = ""
    @State var password = ""
    var body: some View {
        VStack {
            // input de email
            TextField("Escribe tu email", text: $email)
            // formato de texto
                .keyboardType(.emailAddress)
                .padding(16)
                .background(.gray.opacity(0.2))
                .cornerRadius(16)
                .padding(.horizontal, 32)
            // funcion de cambio de contenido
            // oldValue : valor antiguo
            // newValue : valor nuevo
                .onChange(of: email) { oldValue, newValue in
                    print("El antiguo valor era \(oldValue) y el nuevo es \(newValue)")
                }
            SecureField("Escribe tu contraseña", text: $password)
                .keyboardType(.emailAddress)
                .padding(16)
                .background(.gray.opacity(0.2))
                .cornerRadius(16)
                .padding(.horizontal, 32)
                .onChange(of: password) { oldValue, newValue in
                    print("El antiguo valor era \(oldValue) y el nuevo es \(newValue)")
                }
        }
    }
}

#Preview {
    TextFieldExample()
}
