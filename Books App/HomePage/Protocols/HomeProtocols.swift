//
//  HomeProtocols.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

protocol ViewToPresenterHomeProtocol {
    var homeInteractor: PresenterToInteracterHomeProtocol? { get set }
    var homeView: PresenterToInteracterHomeProtocol? { get set }
    
    func loadBooks()
}

protocol PresenterToInteracterHomeProtocol {
    var homePresenter: InteractorToPresenterHomeProtocol? { get set }
    
    func loadAllBooks()
}

protocol InteractorToPresenterHomeProtocol {
    
}

protocol PresenterToViewHomeProtocol {
    
}

protocol PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeVC)
}
