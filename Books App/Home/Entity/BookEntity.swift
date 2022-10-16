//
//  BookEntity.swift
//  Books App
//
//  Created by Berkay on 16.10.2022.
//

import Foundation


struct BookEntity {
    
    var id: String?
    var title: String?
    var bookImage: String?
    var bookDate: String?
    var authorName: String?
    
    init(id: String, title: String, bookImage: String, bookDate: String, authorName: String) {
        self.id = id
        self.title = title
        self.bookImage = bookImage
        self.bookDate = bookDate
        self.authorName = authorName
    }
}
