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
    
    func loadAllBooks(pagination: Int) {
        
        let baseRequestModel = BookRequestModel(paginationTotal: pagination)
        BookNetwork().requestData(request: baseRequestModel) { (result: Result<Welcome, Error>) in
            switch result {
            case .success(let success):
                if let books = success.feed?.results {
                    self.homePresenter?.dataTransferToPresenter(with: books)
                }
            case .failure(_):
                break
            }
        }
    }
    
    func addFavoriteMyBook(_ id: String, _ title: String, _ image: String) {
        
        CoreDataManager.shared.addFavoriteMyBook(id, title, image)
    }
    
    func deleteFavoriteMyBook(_ id: String) {
        
        CoreDataManager.shared.deleteFavoriteMyBook(id)
    }
    
    func fetchCoreDataBooks() -> [BooksEntity] {
        return CoreDataManager.shared.fetchAllData()
    }
}
