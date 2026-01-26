//
//  Item.swift
//  MediaTracker
//
//  Created by Mac-Jakub on 18/01/2026.
//

import Foundation
import SwiftData

@Model
class Media {
    var name: String
    var director: String
    var type: String
    var isWatched: Bool
    var isFavourite: Bool
    var yourRating: Int
    var creationDate: Date
    
    init(name: String, director: String, type: String, isWatched: Bool, isFavourite: Bool, yourRating: Int){
        self.name = name
        self.director = director
        self.type = type
        self.isWatched = isWatched
        self.isFavourite = isFavourite
        self.yourRating = yourRating
        self.creationDate = Date()
    }
}
