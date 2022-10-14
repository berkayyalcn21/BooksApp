//
//  DetailsInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class DetailsInteractor: PresenterToInteractorDetailsProtocol {
    
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
