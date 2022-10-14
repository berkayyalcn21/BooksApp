//
//  HomeInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation
import CoreData


class HomeInteractor: PresenterToInteracterHomeProtocol {
    
    var homePresenter: InteractorToPresenterHomeProtocol?
    
    func stringToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: string)
        dateFormatter.string(from: date!)
        return date ?? .now
    }
    
    func loadAllBooks(pagination: Int) {
        
        let baseRequestModel = BookRequestModel(paginationTotal: pagination)
        BookNetwork().requestData(request: baseRequestModel) { (result: Result<Welcome, Error>) in
            switch result {
            case .success(let success):
                if let books = success.feed?.results {
                    let booksList: [BooksList] = books.map {
                        let date = self.stringToDate($0.releaseDate ?? "")
                        return BooksList(artistName: $0.artistName, id: $0.id, name: $0.name, releaseDate: date, artworkUrl100: $0.artworkUrl100) }
                    self.homePresenter?.dataTransferToPresenter(with: booksList)
                }
            case .failure(_):
                break
            }
        }
    }
    
    func addFavoriteMyBook(_ id: String, _ title: String, _ image: String, _ authorName: String, _ bookDate: String) {
        
        CoreDataManager.shared.addFavoriteMyBook(id, title, image, authorName, bookDate)
    }
    
    func deleteFavoriteMyBook(_ id: String) {
        
        CoreDataManager.shared.deleteFavoriteMyBook(id)
    }
    
    func fetchCoreDataBooks() -> [BooksEntity] {
        return CoreDataManager.shared.fetchAllData()
    }
}
