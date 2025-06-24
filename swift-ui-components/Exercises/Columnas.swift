//
//  Columnas.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

struct Columnas: View {
    var body: some View {
        VStack {
            //columnas superior
            HStack{
                Rectangle()
                    .foregroundColor(.blue)
                Rectangle()
                    .foregroundColor(.orange)
                Rectangle()
                    .foregroundColor(.yellow)
            }.frame(height: 100)
            // columna intermedia superior
            Rectangle()
                .frame(height: 100)
                .foregroundColor(.orange)
            // columnas central
            HStack{
                Circle()
                    .foregroundColor(.green)
                Rectangle()
                Circle()
                    .foregroundColor(.indigo)
            }.frame(height: 250)
            // columna intermedia inferior
            Rectangle()
                .frame(height: 100)
                .foregroundColor(.orange)
            //columnas inferior
            HStack{
                Rectangle()
                    .foregroundColor(.blue)
                Rectangle()
                    .foregroundColor(.orange)
                Rectangle()
                    .foregroundColor(.yellow)
            }.frame(height: 100)
        }
        //indicamos el color de fondo
        .background(.red)
    }
}

#Preview {
    Columnas()
}
