//
//  FavoritesPresenter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

class FavoritesPresenter: ViewToPresenterFavoritesProtocol {
    
    var favoritesInteractor: PresenterToInteractorFavoritesProtocol?
    var favoritesView: PresenterToViewFavoritesProtocol?
    
    func fetchData() {
        favoritesInteractor?.fetchAllData()
    }
}

extension FavoritesPresenter: InteractorToPresenterFavoritesProtocol {
    
    func dataTransferToPresenter(favorites: Array<BooksEntity>) {
        favoritesView?.dataTransferToView(favorites: favorites)
    }
}
