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
    var filterButton: FilterButton? { get set }
    
    func loadBooks(pagination: Int)
    func addFavoriteBook(bookEntity: BookEntity)
    func deleteFavoriteBook(_ id: String)
    func fetchCoreDataList() -> [BooksEntity]
    func filteredList()
}

protocol PresenterToInteracterHomeProtocol {
    var homePresenter: InteractorToPresenterHomeProtocol? { get set }
    
    func loadAllBooks(pagination: Int)
    func addFavoriteMyBook(bookEntity: BookEntity)
    func deleteFavoriteMyBook(_ id: String)
    func fetchCoreDataBooks() -> [BooksEntity]
}

protocol InteractorToPresenterHomeProtocol {
    func dataTransferToPresenter(with booksList: [BooksList])
}

protocol PresenterToViewHomeProtocol {
    func updateData(with booksList: [BooksList])
    func updateError(with error: String)
}

protocol PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeVC)
}
