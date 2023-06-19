//
//  ItemDetailView.swift
//  iExpire
//
//  Created by Andy Wu on 1/21/23.
//

import SwiftUI
import CoreData

struct ItemDetailView: View {
    
    @Environment(\.verticalSizeClass) var vsc
    @ObservedObject var item: Item
    @State private var isEditing = false
    
    var body: some View {
        NavigationStack {
            ItemDetailPortrait(item: item)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isEditing = true
                        } label: {
                            Text("Edit")
                        }
                    }
                }
                .sheet(isPresented: $isEditing) {
                ItemEditView(item: item)
            }
            .navigationTitle("Food Details")
        }
    }
    
    struct ItemDetailPortrait: View {
        
        @ObservedObject var item: Item
        private let cornerRadius: CGFloat = 20
        
        var body: some View {
            Form {
                Section("Food Details") {
                    HStack{
                        Text("Food Name")
                        Text(item.wrappedName)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        Text("Food Category")
                        Text(item.wrappedCategory)
                            .multilineTextAlignment(.trailing)
                    }
                }
                    Section("Notes") {
                        VStack {
                            LoadedImageView(imageData: item.image)
                                .cornerRadius(cornerRadius)
                                .padding()
                                
                            if !item.wrappedNotes.isEmpty {
                                Section {
                                    HStack{
                                        Text("Notes")
                                        Text(item.wrappedNotes)
                                    }
                                }
                            }
                        }
                    }
                    Section("Dates") {
                        HStack{
                            Text("Date of Expiration")
                            ExpirationTextView(expirationDate: item.wrappedDateTime)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
        }
    }
}

struct LoadedImageView: View {
    var imageData: Data?
    
    var body: some View {
        if let imageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let item = Item(context: moc)
        item.name = "Bananas"
        item.notes = "Food is expiring Soon"
        item.category = "Food"
        item.expirationDate = dateToFormatString(date: Date.now)
          
        return ItemDetailView(item: item)
    }
}


