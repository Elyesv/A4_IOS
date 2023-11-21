//
//  EditDataScreen.swift
//  A4_IOS
//
//  Created by Elyes Voisin on 21/11/2023.
//

import Foundation
import SwiftUI

struct EditDataScreen: View {
    
    @State private var editedStartKilometer: String
    @State private var editedEndKilometer: String
    @State private var editedDate: Date
    @State private var editedPictureURL: String
    
    @ObservedObject var data: DataSchema
    
    @Environment(\.presentationMode) var presentationMode
    
    init(data: DataSchema) {
        self.data = data
        self._editedStartKilometer = State(initialValue: "\(data.start_kilometre)")
        self._editedEndKilometer = State(initialValue: "\(data.end_kilometre)")
        self._editedDate = State(initialValue: data.date)
        self._editedPictureURL = State(initialValue: data.pictureURL)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    Section{
                        TextField("Début Kilomètre", text: $editedStartKilometer)
                            .keyboardType(.numberPad)
                        
                        TextField("Fin Kilomètre", text: $editedEndKilometer)
                            .keyboardType(.numberPad)
                    }
                    
                    Section{
                        TextField("URL de l'image", text: $editedPictureURL)
                    }
                    
                    Section{
                        DatePicker("Sélectionnez une date", selection: $editedDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                    }
                    
                    Section{
                        Button(action: {
                            data.start_kilometre = editedStartKilometer
                            data.end_kilometre = editedEndKilometer
                            data.date = editedDate
                            data.pictureURL = editedPictureURL
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Enregistrer")
                        }
                    }
    
                }
            }
            .navigationBarTitle("Modifier", displayMode: .inline)
        }
    }
    
}



struct NewPageView_Previews: PreviewProvider {
    static var previews: some View {
        EditDataScreen(data: DataSchema.DataPreview[0])
    }
}
