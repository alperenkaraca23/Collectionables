//
//  Model.swift
//  Collectionables
//
//  Created by Alperen KARACA on 17.02.2025.
//

import Foundation
import SwiftUI
import CoreData

struct CollectionItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var imageData: Data?
    var notes: String
}

struct Collection: Identifiable, Codable {
    var id = UUID()
    var name: String
    var items: [CollectionItem]
}
