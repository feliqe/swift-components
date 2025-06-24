//
//  MapExample.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 22-06-25.
//

import SwiftUI
import MapKit

struct MapExample: View {
    // indicacion inicial
    @State var position = MapCameraPosition.region(
        // pasamo atributos
        MKCoordinateRegion(
            //rango de ubicacion
            center: CLLocationCoordinate2D(latitude:-33.4225, longitude:-70.6122),
            span: MKCoordinateSpan(latitudeDelta: 0.005
                                   , longitudeDelta: 0.005)
        )
    )
    
    var body: some View {
        ZStack{
            MapReader{ proxy in
                Map(position: $position){
                    // Colocar un punto y el titulo en la coordenadas
                    Annotation("Jardín Japonés de la Amistad", coordinate: CLLocationCoordinate2D(latitude:-33.4266, longitude:-70.6106)){
                        Circle().frame(height: 10)
                    }.annotationTitles(.visible)
                }
                // muestra trafico en las calles
                .mapStyle(.hybrid(elevation: .realistic, showsTraffic: true))
                // para buscar siempre la latitude y la longitude al moverse
                //                .onMapCameraChange { context in
                //                    print("Estamos en: \(context.region)")
                //                }
                
                .onMapCameraChange(frequency: .continuous) { context in
                    print("Estamos en: \(context.region)")
                }
                // al presionar se movera y en la consola mostrara la coordenada
                .onTapGesture { coord in
                    if let coordinates = proxy.convert(coord, from: .local){
                        withAnimation{
                            position = MapCameraPosition.region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude:coordinates.latitude, longitude:coordinates.longitude),
                                    span: MKCoordinateSpan(latitudeDelta: 0.005
                                                           , longitudeDelta: 0.005)
                                )
                            )
                        }
                    }
                }
            }
            
            // tener boton para ir al norte y al sur
            VStack{
                Spacer()
                HStack{
                    Button("Ir al norte"){
                        withAnimation{
                            position = MapCameraPosition.region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude:-18.48398, longitude:-70.31301),
                                    span: MKCoordinateSpan(latitudeDelta: 0.05
                                                           , longitudeDelta: 0.05)
                                )
                            )
                        }
                        
                    }.padding(32).background(.white).padding()
                    Button("Ir al sur"){
                        withAnimation{
                            position = MapCameraPosition.region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude:-41.47488, longitude:-72.93461),
                                    span: MKCoordinateSpan(latitudeDelta: 0.05
                                                           , longitudeDelta: 0.05)
                                )
                            )
                        }
                    }.padding(32).background(.white).padding()
                }
            }
        }
        
    }
    
}

#Preview {
    MapExample()
}
