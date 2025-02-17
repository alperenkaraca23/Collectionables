//
//  ContentView.swift
//  Collectionables
//
//  Created by Alperen KARACA on 17.02.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var viewModel = CollectionViewModel()
    @State private var newCollectionName = ""
    @State private var isAddingCollection = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.collections) { collection in
                    NavigationLink(destination: CollectionDetailView(viewModel: viewModel, collection: collection)) {
                        Text(collection.name)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        viewModel.deleteCollection(viewModel.collections[index].id)
                    }
                }
            }
            .navigationTitle("Koleksiyonlar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("+") { isAddingCollection = true }
                }
            }
            .sheet(isPresented: $isAddingCollection) {
                AddCollectionView(viewModel: viewModel, isPresented: $isAddingCollection)
            }
        }
    }
}

#Preview {
    ContentView()
}
