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
    
    @State private var pictureURL: String = ""
    @State private var start_kilometre = ""
    @State private var end_kilometre = ""
    @State private var date: Date = Date()
    
    var onAddData: ((DataSchema) -> Void)?

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Form{
                Section("Ajout d'une photo") {
                    TextField("Lien de la photo", text: $pictureURL)
                }
                
                Section("Date") {
                    DatePicker("Date du trajet", selection: $date, displayedComponents: [.date, .hourAndMinute])
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
                    TextField("Kilometrage à la fin", text: $end_kilometre)
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
                        let newData = DataSchema(
                            pictureURL: self.pictureURL,
                            date: self.date,
                            start_kilometre: self.start_kilometre,
                            end_kilometre: self.end_kilometre
                        )
                        self.onAddData?(newData)
                                                
                        self.pictureURL = ""
                        self.start_kilometre = ""
                        self.end_kilometre = ""
                        self.date = Date()
                        
                        self.presentationMode.wrappedValue.dismiss()
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
