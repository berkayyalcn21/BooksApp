//
//  DetailsInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class DetailsInteractor: PresenterToInteractorDetailsProtocol {
    
    // Add to core data
    func addFavoriteMyBook(_ id: String, _ title: String, _ image: String, _ authorName: String, _ bookDate: String) {
        
        CoreDataManager.shared.addFavoriteMyBook(id, title, image, authorName, bookDate)
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
