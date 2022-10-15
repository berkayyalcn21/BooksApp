//
//  FavoritesInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation
import CoreData

class FavoritesInteractor: PresenterToInteractorFavoritesProtocol {
    
    var favoritesPresenter: InteractorToPresenterFavoritesProtocol?
    
    // Fetch data
    func fetchAllData() {
        let coreDataList = CoreDataManager.shared.fetchAllData()
        favoritesPresenter?.dataTransferToPresenter(favorites: coreDataList)
    }
}
