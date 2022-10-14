//
//  SearchPresenter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class SearchPresenter: ViewToPresenterSearchProtocol {
    
    var searchInteractor: PresenterToInteractorSearchProtocol?
    var searchView: PresenterToViewSearchProtocol?
    
    func fetchData() {
        searchInteractor?.fetchAllData()
    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
    func dataTransferToPresenter(with books: [Books]) {
        searchView?.updateData(with: books)
    }
}
