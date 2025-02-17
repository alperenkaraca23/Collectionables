//
//  ViewModel.swift
//  Collectionables
//
//  Created by Alperen KARACA on 17.02.2025.
//

import Foundation
import SwiftUI
import CoreData

class CollectionViewModel: ObservableObject {
    @Published var collections: [Collection] = [] {
        didSet { saveData() }
    }
    
    let storageKey = "collectionsData"
    
    init() {
        loadData()
    }
    
    func addCollection(name: String) {
        let newCollection = Collection(name: name, items: [])
        collections.append(newCollection)
    }
    
    func addItem(to collectionID: UUID, item: CollectionItem) {
        if let index = collections.firstIndex(where: { $0.id == collectionID }) {
            collections[index].items.append(item)
        }
    }
    
    func deleteItem(from collectionID: UUID, itemID: UUID) {
        if let index = collections.firstIndex(where: { $0.id == collectionID }) {
            collections[index].items.removeAll { $0.id == itemID }
        }
    }
    
    func deleteCollection(_ collectionID: UUID) {
        collections.removeAll { $0.id == collectionID }
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(collections) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Collection].self, from: savedData) {
            collections = decoded
        }
    }
}
