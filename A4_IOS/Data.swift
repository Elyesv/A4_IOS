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
        DataSchema(pictureURL: "https://images.unsplash.com/photo-1700359387203-d24d08d07b04?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", date: Date(), start_kilometre: "12", end_kilometre: "21"),
        DataSchema(pictureURL: "https://images.unsplash.com/photo-1700636417590-fbe716b6a082?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", date: Date(), start_kilometre: "21", end_kilometre: "42"),
        DataSchema(pictureURL: "https://images.unsplash.com/photo-1700317440743-ffe7b2134276?q=80&w=2686&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", date: Date(), start_kilometre: "42", end_kilometre: "66"),
        DataSchema(pictureURL: "https://images.unsplash.com/photo-1700495405574-dceab5cc64b8?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", date: Date(), start_kilometre: "66", end_kilometre: "112"),
        DataSchema(pictureURL: "https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", date: Date(), start_kilometre: "112", end_kilometre: "213"),
    ]
}
