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
}

protocol PresenterToInteracterHomeProtocol {
    var homePresenter: InteractorToPresenterHomeProtocol? { get set }
    
    func loadAllBooks(pagination: Int)
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
