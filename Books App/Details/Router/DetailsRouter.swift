//
//  DetailsRouter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

class DetailsRouter: PresenterToRouterDetailsProtocol {
    static func createModule(ref: DetailsVC) {
        let presenter = DetailsPresenter()
        
        // View
        ref.detailsPresenterObject = presenter
        
        // Presenter
        ref.detailsPresenterObject?.detailsInteractor = DetailsInteractor()
    }
}
