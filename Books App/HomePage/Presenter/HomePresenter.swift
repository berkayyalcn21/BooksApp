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
    
    func dataTransferToPresenter(_ bookList: Swift.Result<[Result], Error>) {
        switch bookList {
        case.success(let books):
            homeView?.updateData(with: books)
        case.failure(_):
            homeView?.updateError(with: "Try again...")
        }
    }
}
