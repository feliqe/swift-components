//
//  SuperheroSearcher.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI
// package de https://github.com/SDWebImage/SDWebImageSwiftUI
import SDWebImageSwiftUI

struct SuperheroSearcher: View {
    @State var superheroName:String = ""
    // para conectart el ApiNetwork
    @State var wrapper:ApiNetwork.Wrapper? = nil
    @State var loading:Bool = false
    var body: some View {
        VStack{
            // estilo del contenido
            // prompt : se puede personlizar el contenido
            TextField("", text: $superheroName, prompt: Text("Batman...").font(.title2).bold().foregroundColor(.gray)).font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(16)
                .border(.purple, width: 1.5)
                .padding(8)
                .autocorrectionDisabled()
                .onSubmit {
                    loading = true
                    print(superheroName)
                    Task{
                        do{
                            // consulta la api por medio del ApiNetwork para traer todo
                            wrapper = try await ApiNetwork().getHeroesByQuery(query: superheroName)
                        }catch{
                            print("Error")
                        }
                        // corta el progreso de la carga
                        loading = false
                    }
                }
            // al momento de buscar muestre un circulo de carga
            if loading{
                ProgressView().tint(.blue)
            }
            NavigationStack{
                List(wrapper?.results ?? []){ superhero in
                    ZStack{
                        SuperheroItem(superhero: superhero)
                        // cada ves que se presione la imagen se ingresara a SuperheroDetail donde se toma el id
                        NavigationLink(destination: SuperheroDetail(id: superhero.id)){EmptyView()}.opacity(0)
                    }.listRowBackground(Color.backgroundApp)
                    // estilo de contenedor
                }.listStyle(.plain)
            }
            Spacer()
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.backgroundApp)
    }
}

// estructura en donde se motrara la infomacion del super hero
struct SuperheroItem:View {
    let superhero:ApiNetwork.Superhero
    var body: some View {
        ZStack{
            // estilo de la imagen
            WebImage(url: URL(string: superhero.image.url))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            // estilo de la informacion
            VStack{
                Spacer()
                Text(superhero.name).foregroundColor(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.white.opacity(0.5))
            }
        }.frame(height: 200).cornerRadius(32)
        
    }
}

#Preview {
    SuperheroSearcher()
}
