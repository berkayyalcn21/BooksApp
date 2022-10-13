//
//  HomePresenter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

class HomePresenter: ViewToPresenterHomeProtocol {
    
    var homeInteractor: PresenterToInteracterHomeProtocol?
    var homeView: PresenterToViewHomeProtocol?
    
    func loadBooks(pagination: Int) {
        homeInteractor?.loadAllBooks(pagination: pagination)
    }
    
    func addFavoriteBook(_ id: String, _ title: String, _ image: String) {
        homeInteractor?.addFavoriteMyBook(id, title, image)
    }
    
    func deleteFavoriteBook(_ id: String) {
        homeInteractor?.deleteFavoriteMyBook(id)
    }
    
    func fetchCoreDataList() -> [BooksEntity] {
        return homeInteractor?.fetchCoreDataBooks() ?? []
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    
    func dataTransferToPresenter(with books: [Books]) {
        self.homeView?.updateData(with: books)
    }
}
