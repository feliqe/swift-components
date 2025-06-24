//
//  ListExample.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI

// array con contenidos
var pokemons = [
    Pokemon(name: "Pikachu"),
    Pokemon(name: "Charmander"),
    Pokemon(name: "Charmilion"),
    Pokemon(name: "Charizard"),
    Pokemon(name: "AristiDevs")
]
var digimons = [
    Digimon(name: "Agumon"),
    Digimon(name: "Graymon"),
    Digimon(name: "AristiDevsMon"),
    Digimon(name: "AristiDevsMon"),
    Digimon(name: "Supermon"),
    
]

struct ListExample: View {
    var body: some View {
        // listado
        List{
            Section(header: Text("Pokemons")) {
                // recorre el array
                // indicando que el id es el nombre para poder recorrer la lista
                ForEach(pokemons, id:\.name) { pokemon in
                    /*@START_MENU_TOKEN@*/Text(pokemon.name)/*@END_MENU_TOKEN@*/
                }
            }
            Section(header: Text("Digimons")) {
                // recorre el array
                // otro forma tomando el id del constructor
                ForEach(digimons){digimon in
                    Text(digimon.name)
                }
            }
        }.listStyle(.insetGrouped)
    }
}

// constructor para pasar los valores del array
struct Pokemon{
    let name:String
}

// constructor para pasar los valores del array creando el id
struct Digimon: Identifiable{
    var id = UUID()
    let name:String
}


#Preview {
    ListExample()
}
