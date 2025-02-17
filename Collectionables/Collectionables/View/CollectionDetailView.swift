//
//  CollectionDetailView.swift
//  Collectionables
//
//  Created by Alperen KARACA on 17.02.2025.
//

import SwiftUI
import CoreData

struct CollectionDetailView: View {
    @ObservedObject var viewModel: CollectionViewModel
    var collection: Collection
    
    var body: some View {
        List {
            ForEach(collection.items) { item in
                HStack {
                    if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    VStack(alignment: .leading) {
                        Text(item.name).bold()
                        Text(item.notes).font(.caption)
                    }
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    viewModel.deleteItem(from: collection.id, itemID: collection.items[index].id)
                }
            }
        }
        .navigationTitle(collection.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("+", destination: AddItemView(viewModel: viewModel, collectionID: collection.id))
            }
        }
    }
}


