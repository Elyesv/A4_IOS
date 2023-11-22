//
//  ContentView.swift
//  A4_IOS
//
//  Created by Elyes Voisin on 20/11/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject private var array: DataArray = DataArray(dataschemas: DataSchema.DataPreview)
    
    @State private var isSheetPresented = false
    
    
    private func deleteRow(at offsets: IndexSet) {
        array.dataschemas.remove(atOffsets: offsets)
    }
        
    func formattedDate(for date: Date) -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
          return dateFormatter.string(from: date)
      }

    
    var body: some View {
        NavigationView {
            List {
            ForEach(array.dataschemas.indices, id: \.self) { index in
                NavigationLink(destination: DataDetailScreen(data: array.dataschemas[index])) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Date: \(formattedDate(for: array.dataschemas[index].date))")
                            Text("Début Kilomètre: \(array.dataschemas[index].start_kilometre)")
                            Text("Fin Kilomètre: \(array.dataschemas[index].end_kilometre)")
                        }
                    }
                }
            }
            .onDelete(perform: deleteRow)
                
        }
        .navigationBarItems(trailing:
            Button(action: {
                self.isSheetPresented = true
            }) {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }
            .sheet(isPresented: $isSheetPresented) {
                NewDataScreen(onAddData: { newData in

                    self.array.dataschemas.append(newData)
                })
            }
        )
        .navigationBarItems(trailing:
            NavigationLink(destination: GetMeteo()) {
            Image(systemName: "cloud.circle")
        })
        .navigationBarTitle("Historique", displayMode: .inline)
        }
    }
    
}


#Preview {
    ContentView()
}
