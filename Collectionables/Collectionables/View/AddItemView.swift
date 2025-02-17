//
//  AddItemView.swift
//  Collectionables
//
//  Created by Alperen KARACA on 17.02.2025.
//

import SwiftUI
import CoreData

struct AddItemView: View {
    @ObservedObject var viewModel: CollectionViewModel
    var collectionID: UUID
    @State private var name: String = ""
    @State private var notes: String = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    var body: some View {
        Form {
            TextField("İsim", text: $name)
            TextField("Notlar", text: $notes)
            Button("Fotoğraf Seç") { isImagePickerPresented.toggle() }
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            Button("Ekle") { addItem() }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    func addItem() {
        if let selectedImage = selectedImage, let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
            let newItem = CollectionItem(name: name, imageData: imageData, notes: notes)
            viewModel.addItem(to: collectionID, item: newItem)
        }
    }
}

