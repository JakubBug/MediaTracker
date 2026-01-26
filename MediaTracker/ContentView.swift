//
//  ContentView.swift
//  MediaTracker
//
//  Created by Mac-Jakub on 18/01/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(sort: \Media.name) private var media: [Media]
    
    @State private var editingMedia: Media?
    @State private var newItemName = ""
    @State private var newRating = 1
    @State private var newType = "Film"
    @State private var newDirector = ""
    @State private var isFavoriteNew: Bool = false
    @State private var isWatchedNew: Bool = false
    
    var types = ["Film", "Serial"]
    var wybor = ["Obejrzane", "Nie obejrzane"]
    
    var body: some View{
        NavigationStack{
            VStack{
                Form{
                    Section(){
                        TextField("Tytuł", text: $newItemName)
                        TextField("Reżyser", text: $newDirector)
                        
                        Picker("Typ", selection: $newType) {
                            ForEach(types, id: \.self) { type in
                                Text(type)
                            }
                            
                        }
                        .pickerStyle(.segmented)
                        
                        
                            Toggle("Obejrzane?", isOn: $isWatchedNew)
                            
                            if isWatchedNew  {
                                Stepper("Ocena: \(newRating) gwiazdek", value: $newRating, in: 1...5)
                                
                            }
                        
                        Button("Dodaj"){
                            addNewItem()
                        }
                        .disabled(newItemName.isEmpty)
                        .disabled(newDirector.isEmpty)
                        
                    }
                }
                .frame(maxHeight: 350)
                
                
                List {
                    ForEach(media) {item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(item.director)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            if item.yourRating > 0 {
                                HStack(spacing: 2) {
                                    ForEach(1...5, id: \.self) { index in
                                        Image(systemName: "star.fill")
                                            .font(.caption2)
                                            .foregroundStyle(index <= item.yourRating ? .yellow : .gray)
                                    }
                                
                                }
                            }
                            
                            
                            
                            Button {
                                item.isFavourite.toggle()
                            } label: {
                                Image(systemName: item.isFavourite ? "star.fill" : "star")
                                    .foregroundStyle(item.isFavourite ? .yellow : .gray)
                            }
                            .buttonStyle(.plain)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            editingMedia = item
                    }
                    
                }
                    .onDelete(perform: deleteItems)
                
                
                }
                            
                        }
            .navigationTitle("Moje filmy i seriale")
            .sheet(item: $editingMedia) { itemToEdit in
                            EditMediaView(item: itemToEdit)
                        }
                    }
                }
    
    private func addNewItem() {
        let ratingToSave = isWatchedNew ? newRating : 0
        let newMedia = Media(name: newItemName, director: newDirector, type: newType, isWatched: isWatchedNew, isFavourite: isFavoriteNew, yourRating: ratingToSave)
                             
        modelContext.insert(newMedia)
        
        newItemName = ""
        newRating = ratingToSave
        newDirector = ""
        
        
    }
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(media[index])
        }
    }
}

struct EditMediaView: View {
    @Bindable var item: Media
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Tytuł", text: $item.name)
                TextField("Reżyser", text: $item.director)
                
                Toggle("Obejrzane?", isOn: $item.isWatched)
                                    .onChange(of: item.isWatched) { oldValue, newValue in
                                       
                                        if newValue == false {
                                            item.yourRating = 0
                                        } else if newValue == true && item.yourRating == 0 {
                                            item.yourRating = 1
                                        }
                                    }
                
                if item.isWatched {
                    Stepper("Ocena:  \(item.yourRating) gwiazdek", value: $item.yourRating, in: 0...5)
                }
                
            }
            .navigationTitle("Edytuj")
            .toolbar {
                Button("Gotowe") {dismiss()}
            }
        }
    }
}
#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    
    let container = try! ModelContainer(for: Media.self, configurations: config)
    
   
    let example = Media(name: "Incepcja",
                        director: "Christopher Nolan",
                        type: "Film",
                        isWatched: true,
                        isFavourite: true,
                        yourRating: 9)
    
    container.mainContext.insert(example)
    

    return ContentView()
        .modelContainer(container)
}



        
    
    



