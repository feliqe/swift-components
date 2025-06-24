//
//  MenuView.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack{
            List{
                // indicamos la ruta de destino y el nombre del menu
                NavigationLink(destination:IMCView()){
                    // nombre del menu
                    Text("IMC Calculator")
                }
                // indicamos la ruta de destino y el nombre del menu
                NavigationLink(destination:SuperheroSearcher()){
                    // nombre del menu
                    Text("Superhero finder")
                }
                // indicamos la ruta de destino y el nombre del menu
                NavigationLink(destination: FavPlaces()){
                    // nombre del menu
                    Text("Fav Places")
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
