//
//  ApiNetwork.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import Foundation

// un contenedor de codigo
class ApiNetwork{
    // estructura de la consulta del array inicial
    struct Wrapper:Codable{
        let response:String
        let results:[Superhero]
    }
    // datos sub array
    struct Superhero:Codable, Identifiable{
        let id:String
        let name:String
        let image:ImageSuperhero
    }
    // datos sub array
    struct ImageSuperhero:Codable{
        let url:String
    }
    // datos del array con buscador
    struct SuperheroCompleted:Codable{
        let id:String
        let name:String
        let image:ImageSuperhero
        let powerstats:Powerstats
        let biography:Biography
    }
    // datos sub array con buscador
    struct Powerstats:Codable{
        let intelligence:String
        let strength:String
        let speed:String
        let durability:String
        let power:String
        let combat:String
    }
    // datos sub array con buscador
    struct Biography:Codable{
        let alignment:String
        let publisher:String
        let aliases:[String]
        let fullName:String
        
        // compara para poder buscar con otro nombre como el de Biography
        enum CodingKeys:String, CodingKey{
            case fullName = "full-name"
            case alignment = "alignment"
            case publisher = "publisher"
            case aliases = "aliases"
        }
    }
    
    // consulta a la api con el access-token trae todos
    func getHeroesByQuery(query:String) async throws -> Wrapper{
        let url = URL(string: "https://superheroapi.com/api/83672685767a7523118f8a8f20739675/search/\(query)")!
        // trae la consulta del json
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // decodificar el json
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        return wrapper
    }
    
    // buscar datos por id en la consulta de la api
    func getHeroById(id:String) async throws -> SuperheroCompleted{
        let url = URL(string: "https://superheroapi.com/api/83672685767a7523118f8a8f20739675/\(id)")!
        // trae la consulta del json
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // decodificar el json con retourn directo
        return try JSONDecoder().decode(SuperheroCompleted.self, from: data)
    }
}
