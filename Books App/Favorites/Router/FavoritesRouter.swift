//
//  FavoritesRouter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

class FavoritesRouter: PresenterToRouterFavoritesProtocol {
    
    static func createModule(ref: FavoritesVC) {
        let presenter = FavoritesPresenter()
        
        // View
        ref.favoritesPresenterObject = presenter
        
        // Presenter
        ref.favoritesPresenterObject?.favoritesView = ref
        ref.favoritesPresenterObject?.favoritesInteractor = FavoritesInteractor()
        
        // Interactor
        ref.favoritesPresenterObject?.favoritesInteractor?.favoritesPresenter = presenter
    }
}
