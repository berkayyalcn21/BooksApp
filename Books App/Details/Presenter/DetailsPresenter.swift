//
//  DetailsPresenter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class DetailsPresenter: ViewToPresenterDetailsProtocol {
    
    var detailsInteractor: PresenterToInteractorDetailsProtocol?
    
    func addFavoriteBook(_ id: String, _ title: String, _ image: String, _ authorName: String, _ bookDate: String) {
        detailsInteractor?.addFavoriteMyBook(id, title, image, authorName, bookDate)
    }
    
    func deleteFavoriteBook(_ id: String) {
        detailsInteractor?.deleteFavoriteMyBook(id)
    }
    
    func fetchCoreDataList() -> [BooksEntity] {
        return detailsInteractor?.fetchCoreDataBooks() ?? []
    }
}
