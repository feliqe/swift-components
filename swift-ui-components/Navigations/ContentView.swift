//
//  ContentView.swift
//  swift-ui-components
//
//  Created by Feliqe Silva on 21-06-25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {

        MenuView()
    }
}

#Preview {
    ContentView()
    //.modelContainer(for: Item.self, inMemory: true)
}
