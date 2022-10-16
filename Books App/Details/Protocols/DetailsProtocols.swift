//
//  DetailsProtocols.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

protocol ViewToPresenterDetailsProtocol {
    var detailsInteractor: PresenterToInteractorDetailsProtocol? { get set }
    
    func addFavoriteBook(bookEntity: BookEntity)
    func deleteFavoriteBook(_ id: String)
    func fetchCoreDataList() -> [BooksEntity]
}

protocol PresenterToInteractorDetailsProtocol {
    
    func addFavoriteMyBook(bookEntity: BookEntity)
    func deleteFavoriteMyBook(_ id: String)
    func fetchCoreDataBooks() -> [BooksEntity]
}

protocol PresenterToRouterDetailsProtocol {
    static func createModule(ref: DetailsVC)
}
