//
//  NewDataScreen.swift
//  A4_IOS
//
//  Created by Elyes Voisin on 20/11/2023.
//

import Foundation
import SwiftUI
import Combine

struct NewDataScreen: View {
    
    @State private var photo_url: String = ""
    @State private var start_kilometre = ""
    @State private var end_kilometre = ""
    @State private var date: Date = Date()
    
    var body: some View {
        VStack{
            Form{
                Section("Ajout d'une photo") {
                    TextField("Lien de la photo", text: $photo_url)
                }
                
                Section("Date") {
                    DatePicker("Date du trajet", selection: $date, displayedComponents: .date)
                }
                
                Section("Kilométrage sur le compteur"){
                    TextField("Kilometrage au départ", text: $start_kilometre)
                                .keyboardType(.numberPad)
                                .onReceive(Just(start_kilometre)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.start_kilometre = filtered
                                    }
                                }
                    TextField("Kilometrage à la fin", text: $start_kilometre)
                                .keyboardType(.numberPad)
                                .onReceive(Just(start_kilometre)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.start_kilometre = filtered
                                    }
                                }
                }
                
                Section{
                    Button(action: {
                        //TODO RAJOUTER LE RAJOUT
                    }, label: {
                        Text("Ajouter")
                    })
                }
                
            }
           
            
        }
        
        
    }
    
}


#Preview {
    NewDataScreen()
}
