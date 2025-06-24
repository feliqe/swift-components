//
//  Place.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 22-06-25.
//

import Foundation
import MapKit

// proceso de guadar datos
struct Place:Identifiable, Codable{
    var id = UUID()
    var name:String
    var coordinates:CLLocationCoordinate2D
    var fav:Bool
    
    // contenedor
    enum CodingKeys:CodingKey{
        case id, name, fav, latitude, longitude
    }
    
    // constructor por defecto
    init(id: UUID = UUID(), name: String, coordinates: CLLocationCoordinate2D, fav: Bool) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.fav = fav
    }
    
    // mantiene la informacion para almacenar
    init(from decoder: Decoder) throws {
        
        // se crea una variable para leer el contenedor y traer los datos de las coordenadas
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        // trae los datos solicitados
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        name = try container.decode(String.self, forKey: .name)
        fav = try container.decode(Bool.self, forKey: .fav)
        id = try container.decode(UUID.self, forKey: .id)
    }
    
    // funcion para decodificar la informacion almacenada
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinates.latitude, forKey: .latitude)
        try container.encode(coordinates.longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
        try container.encode(fav, forKey: .fav)
        try container.encode(id, forKey: .id)
    }
    
}
