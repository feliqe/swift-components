//
//  IMCView.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

struct IMCView: View {
    // para que se muestre el titulos opcion global
    //init(){
    //  UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    //}
    
    @State var gender:Int = 0
    @State var age:Int = 18
    @State var weight:Int = 80
    @State var height:Double = 150
    
    var body: some View {
        VStack{
            HStack{
                // iconos de la seleccion con el valor de genero
                ToggleButton(text: "Hombre", imageName: "figure.stand", gender: 0, selectedGender: $gender )
                ToggleButton(text: "Mujer", imageName: "figure.stand.dress", gender: 1, selectedGender: $gender)
            }
            HeightCalculator(selectedHeight: $height)
            HStack{
                CounterButton(text: "Edad", number: $age)
                CounterButton(text: "Peso", number: $weight)
            }
            IMCCalculateButton(userWeight: Double(weight), userHeight: height)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundApp)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Calculator mi IMC ").bold().foregroundColor(.white)
                }
            }
    }
}

// boton de calcular
struct IMCCalculateButton:View {
    let userWeight:Double
    let userHeight:Double
    
    var body: some View {
        // navegacion al momento de ingresar los datos
        NavigationStack{
            // se direcciona a la vista de resultado
            // se envian los datos de las variables
            NavigationLink(destination:{IMCResult(userWeight: userWeight, userHeight: userHeight)}){
                // estilo del boton
                Text("Calcular").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().foregroundColor(.purple)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 100).background(.backgroundComponent)
            }
        }
    }
}

// boton de genero
struct ToggleButton:View {
    let text:String
    let imageName:String
    let gender:Int
    @Binding var selectedGender:Int
    
    var body: some View {
        
        let color = if(gender == selectedGender){
            Color.backgroundComponentSelected
        }else{
            Color.backgroundComponent
        }
        
        // cambia el color y accion al seleccionar el genero
        Button(action: {
            selectedGender = gender
        }) {
            // formato de los iconos
            VStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.white)
                InformationText(text: text)
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(color)
        }
        
    }
}

// formato de textos del titulo en la view
struct TitleText:View {
    let text:String
    var body: some View {
        Text(text).font(.title2).foregroundColor(.gray)
    }
}

// formato de textos en la view
struct InformationText:View {
    let text:String
    var body: some View {
        Text(text).font(.largeTitle).bold().foregroundColor(.white)
    }
}



// rango de altura
struct HeightCalculator:View {
    @Binding var selectedHeight:Double
    
    var body: some View {
        VStack{
            TitleText(text: "Altura")
            InformationText(text: "\(Int(selectedHeight)) cm")
            // rango de seleccion
            Slider(value: $selectedHeight, in:100...220, step: 1).accentColor(.purple).padding(.horizontal, 16)
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.backgroundComponent)
    }
}
// boton de edad y peso
struct CounterButton:View {
    
    let text:String
    @Binding var number:Int
    var body: some View {
        VStack{
            // estilos de los botones
            TitleText(text: text)
            InformationText(text: String(number))
            HStack{
                // logica de que no sea numero negativo
                Button(action:{
                    if(number > 0){
                        number -= 1
                    }
                }){
                    // boton del campo y un icono (+) sobre puesto
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.purple)
                        Image(systemName: "minus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                        
                    }
                }
                // logica de no ser mayor que 150
                Button(action:{
                    if(number < 150){
                        number += 1
                    }
                }){
                    // colocar un campos y un icono (-) sobre puesto
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.purple)
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                        
                    }
                }
            }
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.backgroundComponent)
    }
}

#Preview {
    IMCView()
}
