//
//  ContentView.swift
//  A4_IOS
//
//  Created by Elyes Voisin on 20/11/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
        
    var body: some View {
        NavigationView(content: {
            NavigationLink(destination: Text("Destination")) { /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }
        })
        
    }
}

#Preview {
    ContentView()
}
