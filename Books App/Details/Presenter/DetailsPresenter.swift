//
//  DetailsPresenter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class DetailsPresenter: ViewToPresenterDetailsProtocol {
    
    var detailsInteractor: PresenterToInteractorDetailsProtocol?
    
    // Add to core data
    func addFavoriteBook(bookEntity: BookEntity) {
        detailsInteractor?.addFavoriteMyBook(bookEntity: bookEntity)
    }
    
    // Delete from core data
    func deleteFavoriteBook(_ id: String) {
        detailsInteractor?.deleteFavoriteMyBook(id)
    }
    
    // Fetch data from core data
    func fetchCoreDataList() -> [BooksEntity] {
        return detailsInteractor?.fetchCoreDataBooks() ?? []
    }
}
