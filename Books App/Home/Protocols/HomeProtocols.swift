//
//  HomeProtocols.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

protocol ViewToPresenterHomeProtocol {
    var homeInteractor: PresenterToInteracterHomeProtocol? { get set }
    var homeView: PresenterToViewHomeProtocol? { get set }
    
    func loadBooks(pagination: Int)
    func addFavoriteBook(_ id: String, _ title: String, _ image: String)
    func deleteFavoriteBook(_ id: String)
    func fetchCoreDataList() -> [BooksEntity]
}

protocol PresenterToInteracterHomeProtocol {
    var homePresenter: InteractorToPresenterHomeProtocol? { get set }
    
    func loadAllBooks(pagination: Int)
    func addFavoriteMyBook(_ id: String, _ title: String, _ image: String)
    func deleteFavoriteMyBook(_ id: String)
    func fetchCoreDataBooks() -> [BooksEntity]
}

protocol InteractorToPresenterHomeProtocol {
    func dataTransferToPresenter(with books: [Books])
}

protocol PresenterToViewHomeProtocol {
    func updateData(with books: [Books])
    func updateError(with error: String)
}

protocol PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeVC)
}
