//
//  SearchRouter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class SearchRouter: PresenterToRouterSearchProcotocol {
    
    static func createModule(ref: SearchVC) {
        let presenter = SearchPresenter()
        
        // View
        ref.searchPresenterObject = presenter
        
        // Presenter
        ref.searchPresenterObject?.searchView = ref
        ref.searchPresenterObject?.searchInteractor = SearchInteractor()
        
        // Interactor
        ref.searchPresenterObject?.searchInteractor?.searchPresenter = presenter
    }
}
