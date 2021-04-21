//
//  ModelRecipe.swift
//  Multivarka
//
//  Created by Anastasia Tetyueva on 18.12.2020.
//

import Foundation

class ModelRecipe {
    var name: String
    var previewIcon: String
    var text: String
    var image: String
    var shortText: String
    var videoURL: String
    var authorName: String
    var date: String
    var duration: String
    var portions: Int
    var likes: Int
    var isFavorite: Bool
    
    init(name: String, previewIcon: String, text: String, image: String, shortText: String, videoURL: String, authorName: String, date: String, duration: String, portions: Int, likes: Int, isFavorite: Bool) {
        self.name = name
        self.previewIcon = previewIcon
        self.text = text
        self.image = image
        self.shortText = shortText
        self.videoURL = videoURL
        self.authorName = authorName
        self.date = date
        self.duration = duration
        self.portions = portions
        self.likes = likes
        self.isFavorite = isFavorite
    }
}
