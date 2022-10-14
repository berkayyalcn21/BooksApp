//
//  SearchProtocols.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

protocol ViewToPresenterSearchProtocol {
    var searchInteractor: PresenterToInteractorSearchProtocol? { get set }
    var searchView: PresenterToViewSearchProtocol? { get set }
    
    func fetchData()
}

protocol PresenterToInteractorSearchProtocol {
    var searchPresenter: InteractorToPresenterSearchProtocol? { get set }
    
    func fetchAllData()
}

protocol InteractorToPresenterSearchProtocol {
    func dataTransferToPresenter(with books: [Books])
}

protocol PresenterToViewSearchProtocol {
    func updateData(with books: [Books])
    func updateError(with error: String)
}

protocol PresenterToRouterSearchProcotocol {
    static func createModule(ref: SearchVC)
}
