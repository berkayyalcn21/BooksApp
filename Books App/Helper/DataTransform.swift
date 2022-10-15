//
//  DataTransform.swift
//  Books App
//
//  Created by Berkay on 15.10.2022.
//

import Foundation

class DataTransform {
    
    static var shared = DataTransform()
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    func transformToBooks(_ booksList: [BooksList]) -> [Books] {
        booksList.map {
            let date = self.dateToString($0.releaseDate ?? .now)
            return Books(artistName: $0.artistName, id: $0.id, name: $0.name, releaseDate: date, kind: nil, artistID: nil, artistURL: nil, contentAdvisoryRating: nil, artworkUrl100: $0.artworkUrl100, genres: nil, url: nil)
        }
    }

    func transformToDetails(_ booksList: [BooksList]) -> [DetailsEntity] {
        let newBooksList: [Books] = transformToBooks(booksList)
        return newBooksList.map {
            .init(id: $0.id!, imageView: $0.artworkUrl100!, bookTitle: $0.name!, authorName: $0.artistName!, bookDate: $0.releaseDate!) }
    }
    
    func transformBooksToDetails(_ books: [Books]) -> [DetailsEntity] {
        return books.map {
            .init(id: $0.id!, imageView: $0.artworkUrl100!, bookTitle: $0.name!, authorName: $0.artistName!, bookDate: $0.releaseDate!) }
    }
    
    func transformBooksEntityToDetails(_ toDetails: [BooksEntity]) -> [DetailsEntity] {
        return toDetails.map { .init(id: $0.id!, imageView: $0.bookImage!, bookTitle: $0.title!, authorName: $0.authorName!, bookDate: $0.bookDate!) }
    }
    
}

