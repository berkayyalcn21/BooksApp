//
//  FavoritesProtocols.swift
//  Books App
//
//  Created by Berkay on 13.10.2022.
//

import Foundation

protocol ViewToPresenterFavoritesProtocol {
    var favoritesInteractor: PresenterToInteractorFavoritesProtocol? { get set }
    var favoritesView: PresenterToViewFavoritesProtocol? { get set }
    
    func loadBooks()
}

protocol PresenterToInteractorFavoritesProtocol {
    var favoritesPresenter: InteractorToPresenterFavoritesProtocol? { get set }
    
    func loadAllBooks()
}

protocol InteractorToPresenterFavoritesProtocol {
    func dataTransferToPresenter(favorites: Array<BooksEntity>)
}

protocol PresenterToViewFavoritesProtocol {
    func dataTransferToView(favorites: Array<BooksEntity>)
}

protocol PresenterToRouterFavoritesProtocol {
    static func createModule(ref: FavoritesVC)
}
