//
//  DataDetailScreen.swift
//  A4_IOS
//
//  Created by Elyes Voisin on 21/11/2023.
//

import Foundation
import SwiftUI

struct DataDetailScreen: View {
    @ObservedObject var data: DataSchema
    @State private var isEditing = false
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: data.pictureURL)) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
            }
            Text("Date: \(formattedDate)")
            Text("Début Kilomètre: \(data.start_kilometre)")
            Text("Fin Kilomètre: \(data.end_kilometre)")
            // Ajoutez ici d'autres détails selon vos besoins
            
        }
        .navigationBarTitle("Détails", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.isSheetPresented = true
            }) {
                Image(systemName: "pencil.circle")
                    .imageScale(.large)
            }            .sheet(isPresented: $isSheetPresented) {
                EditDataScreen(data: data)
            }
        )
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: data.date)
    }
}

