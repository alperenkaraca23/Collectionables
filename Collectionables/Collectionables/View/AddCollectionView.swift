//
//  AddCollectionView.swift
//  Collectionables
//
//  Created by Alperen KARACA on 17.02.2025.
//

import SwiftUI
import CoreData

struct AddCollectionView: View {
    @ObservedObject var viewModel: CollectionViewModel
    @Binding var isPresented: Bool
    @State private var collectionName: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Koleksiyon İsmi", text: $collectionName)
                Button("Ekle") {
                    if !collectionName.isEmpty {
                        viewModel.addCollection(name: collectionName)
                        isPresented = false
                    }
                }
            }
            .navigationTitle("Yeni Koleksiyon")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") { isPresented = false }
                }
            }
        }
    }
}
