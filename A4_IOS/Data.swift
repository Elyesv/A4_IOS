//
//  Data.swift
//  A4_IOS
//
//  Created by Elyes Voisin on 20/11/2023.
//

import Foundation
import SwiftUI

struct DataSchema: Identifiable {
    let id: UUID = UUID()
    let pictureURL: String
    let date: Date
    let start_kilometre: String
    let end_kilometre: String
    
    static let DataPreview: [DataSchema] = [
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "12", end_kilometre: "21"),
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "21", end_kilometre: "42"),
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "42", end_kilometre: "66"),
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "66", end_kilometre: "112"),
        DataSchema(pictureURL: "none", date: Date(), start_kilometre: "112", end_kilometre: "213"),
    ]
}
