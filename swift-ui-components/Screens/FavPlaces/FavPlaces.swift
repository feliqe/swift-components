//
//  FavPlaces.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 22-06-25.
//

import SwiftUI
import MapKit

struct FavPlaces: View {
    @State var position = MapCameraPosition.region(
        // coordenadas inicial
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude:-41.47488, longitude:-72.93461),
            span:MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    // places:[Place] = []  donde indicamos que importamos la informacion de la hoja de Place del modelo
    @State var places:[Place] = []
    // obtejto con las codenadas
    @State var showPopUp:CLLocationCoordinate2D? = nil
    // variables para el formulario popUp
    @State var name:String = ""
    @State var fav:Bool = false
    // variable para mostrar boton de la lista
    @State var showSheet = false
    
    let height = stride(from: 0.3, through: 0.3, by: 0.1).map{ PresentationDetent.fraction($0)}
    
    var body: some View {
        ZStack{
            MapReader{ proxy in
                Map(position: $position){
                    // funcion para colocar los circulos
                    ForEach(places){ place in
                        Annotation(place.name, coordinate: place.coordinates) {
                            // validar si es favorito o no para mostra en el mapa
                            let color = if place.fav { Color.yellow }else{ Color.black }
                            
                            Circle()
                                .stroke(color, lineWidth: 3)
                                .fill(.white)
                                .frame(width: 35, height: 35)
                        }
                    }
                }
                .onTapGesture { coord in
                    if let coordinates = proxy.convert(coord, from: .local){
                        showPopUp = coordinates
                    }
                }
                .overlay{
                    VStack{
                        // panel donde mostrara los campos guardados
                        Button("Show list"){
                            showSheet = true
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.white)
                        .cornerRadius(16)
                        .padding(16)
                        // estilo para que esta en la parte superior
                        Spacer()
                    }
                }
            }
            // para precionar se levantara el dialogo consultando los datos
            if showPopUp != nil{
                let view = VStack{
                    Text("Añadir localización").font(.title2).bold()
                    Spacer()
                    TextField("Nombre", text: $name).padding(.bottom, 8)
                    Toggle("¿Es un lugar favorito?", isOn: $fav)
                    Spacer()
                    Button("Guardar"){
                        //  funciones para guardar y borrar datos del popUp
                        savePlace(name: name, fav: fav, coordinates: showPopUp!)
                        clearForm()
                    }
                }
                // animacion del popUp para cerrar
                withAnimation{
                    CustomDialog(closeDialog: {
                        showPopUp = nil
                    }, onDismissOutside: false, content: view)
                }
                
            }
            
        }.sheet(isPresented: $showSheet) {
            // panel en donde se veran los datos guadados
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(places){ place in
                        // validara si es favorito o no para mostra en el popUp
                        let color = if place.fav{ Color.yellow.opacity(0.5) }else{ Color.black.opacity(0.5)}
                        VStack{
                            Text(place.name).font(.title3).bold()
                        }.frame(width: 150, height: 100).overlay{
                            RoundedRectangle(cornerRadius: 20).stroke(color, lineWidth: 1)
                        }.shadow(radius: 5).padding(.horizontal, 8)
                            .onTapGesture {
                                animateCamera(coordinates: place.coordinates)
                                showSheet = false
                            }
                    }
                }
            }.presentationDetents(Set(height))
        }.onAppear{
            loadPlaces()
        }
    }
    
    //funcion para animar la pantalla a la posicion de la cordinada que se selecciona
    func animateCamera(coordinates:CLLocationCoordinate2D){
        withAnimation{
            position = MapCameraPosition.region(
                MKCoordinateRegion(
                    center:coordinates,
                    span:MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                )
            )
        }
    }
    // funcion que recibe los datos para poder guardarlos
    // datos de guardar si es favorito o no
    func savePlace(name:String, fav:Bool, coordinates:CLLocationCoordinate2D){
        let place = Place(name: name, coordinates: coordinates, fav: fav)
        places.append(place)
        savePlaces()
    }
    
    // limpia los datos del fomrulario
    func clearForm(){
        name = ""
        fav = false
        showPopUp = nil
    }
    
    
}

#Preview {
    FavPlaces()
}

// tiene que tener le mismo nombre para poder tener
extension FavPlaces{
    
    // funcion para guardar
    func savePlaces(){
        if let encodeData = try? JSONEncoder().encode(places){
            // indicamos que carge la informacion cuando se pida la clave de "places"
            UserDefaults.standard.set(encodeData, forKey: "places")
        }
    }
    
    // funcion para cargar los datos
    func loadPlaces(){
        if let savedPlaces = UserDefaults.standard.data(forKey: "places"),
           // para cragar la vista le pasaremos la clave de "places", para cargarlos en places y poder mostrarlos en los popUp
           let decodedPlaces = try? JSONDecoder().decode([Place].self, from: savedPlaces){
            places = decodedPlaces
        }
        
    }
    
    
    
}
