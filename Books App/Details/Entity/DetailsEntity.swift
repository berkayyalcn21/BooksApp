//
//  DetailsEntity.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

class DetailsEntity {
    
    var id: String?
    var imageView: String?
    var bookTitle: String?
    var authorName: String?
    var bookDate: String?
    
    init(id: String, imageView: String, bookTitle: String, authorName: String, bookDate: String) {
        self.id = id
        self.imageView = imageView
        self.bookTitle = bookTitle
        self.authorName = authorName
        self.bookDate = bookDate
    }
}
