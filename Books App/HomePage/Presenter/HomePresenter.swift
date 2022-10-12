//
//  HomePresenter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

enum NetworkError: Error {
    case NetworkFailed  // Network connection error
    case ParsingFailed  // Wrong parsing
}

class HomePresenter: ViewToPresenterHomeProtocol {
    
    var homeInteractor: PresenterToInteracterHomeProtocol?
    var homeView: PresenterToViewHomeProtocol?
    
    func loadBooks(pagination: Int) {
        homeInteractor?.loadAllBooks(pagination: pagination)
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    
    func dataTransferToPresenter(with books: [Welcome]) {
        print(books)
    }
}
