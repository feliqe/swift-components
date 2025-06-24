//
//  CustomDialog.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 24-06-25.
//

import SwiftUI

//funcion de dialogo
// <Content:View> = indica que recibira datos
struct CustomDialog <Content:View>: View  {
    //    funcion landa
    let closeDialog:() -> Void
    //onDismissOutside = si pulsa fuera se cierra el dialogo
    let onDismissOutside:Bool
    //    contenido
    let content:Content
    
    
    var body: some View {
        ZStack{
            // color de fondo del texto
            Rectangle().fill(.gray.opacity(0.7))
            //ignoresSafeArea = se indica que usara toda la pantalla
                .ignoresSafeArea()
                .onTapGesture {
                    //  validacion para salir del dialogo
                    if onDismissOutside{
                        withAnimation{
                            closeDialog()
                        }
                    }
                }
            
            content
            // les indicaremos el tamaño de la pantalla
                .frame(width: UIScreen.main.bounds.size.width-100, height: 300)
                .padding()
                .background(.white)
                .cornerRadius(16)
                .overlay(alignment: .topTrailing){
                    Button(action: {
                        withAnimation{
                            closeDialog()
                        }
                    }, label: {
                        Image(systemName: "xmark.circle")
                    }).foregroundColor(.gray).padding(16)
                }
            
            
        }.ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.size.width,
                   height: UIScreen.main.bounds.size.height,
                   alignment: .center)
        
    }
}
