//
//  SearchInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

class SearchInteractor: PresenterToInteractorSearchProtocol {
    
    var searchPresenter: InteractorToPresenterSearchProtocol?
    
    func fetchAllData() {
        let baseRequestModel = BookRequestModel(paginationTotal: 100)
        BookNetwork().requestData(request: baseRequestModel) { (result: Result<Welcome, Error>) in
            switch result {
            case .success(let success):
                if let books = success.feed?.results {
                    self.searchPresenter?.dataTransferToPresenter(with: books)
                }
            case .failure(_):
                break
            }
        }
    }
}
