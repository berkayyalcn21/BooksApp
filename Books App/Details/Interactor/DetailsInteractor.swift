//
//  DetailsInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class DetailsInteractor: PresenterToInteractorDetailsProtocol {
    
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
