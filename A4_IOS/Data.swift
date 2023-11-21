//
//  Data.swift
//  A4_IOS
//
//  Created by Elyes Voisin on 20/11/2023.
//

import Foundation
import SwiftUI

class DataArray: ObservableObject{
    @Published var dataschemas: [DataSchema]
    
    init(dataschemas: [DataSchema]){
        self.dataschemas = dataschemas
    }
}

class DataSchema: Identifiable, ObservableObject{
    let id: UUID = UUID()
    @Published var pictureURL: String
    @Published var date: Date
    @Published var start_kilometre: String
    @Published var end_kilometre: String
    
    init(pictureURL: String, date: Date, start_kilometre: String, end_kilometre: String) {
        self.pictureURL = pictureURL
        self.date = date
        self.start_kilometre = start_kilometre
        self.end_kilometre = end_kilometre
    }
    
}

extension DataSchema {
    static let DataPreview: [DataSchema] = [
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "12", end_kilometre: "21"),
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "21", end_kilometre: "42"),
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "42", end_kilometre: "66"),
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "66", end_kilometre: "112"),
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "112", end_kilometre: "213"),
    ]
}
