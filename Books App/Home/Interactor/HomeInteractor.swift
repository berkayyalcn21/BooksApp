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
    
    // Fetch data books
    func loadAllBooks(pagination: Int) {
        
        let baseRequestModel = BookRequestModel(paginationTotal: pagination)
        BookNetwork().requestData(request: baseRequestModel) { (result: Result<Welcome, Error>) in
            switch result {
            case .success(let success):
                if let books = success.feed?.results {
                    let booksList: [BooksList] = books.map {
                        let date = DataTransform.shared.transformStringToDate($0.releaseDate ?? "")
                        return BooksList(artistName: $0.artistName, id: $0.id, name: $0.name, releaseDate: date, artworkUrl100: $0.artworkUrl100) }
                    self.homePresenter?.dataTransferToPresenter(with: booksList)
                }
            case .failure(_):
                break
            }
        }
    }
    
    // Add to core data
    func addFavoriteMyBook(bookEntity: BookEntity) {
        
        CoreDataManager.shared.addFavoriteMyBook(bookEntity: bookEntity)
    }
    
    // Delete from core data
    func deleteFavoriteMyBook(_ id: String) {
        
        CoreDataManager.shared.deleteFavoriteMyBook(id)
    }
    
    // Fetch data from core data
    func fetchCoreDataBooks() -> [BooksEntity] {
        return CoreDataManager.shared.fetchAllData()
    }
}
