//
//  HomePresenter.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

// Home page filter button action
enum FilterButton {
    case All
    case NewToOld
    case OldToNew
    case Favorites
}

class HomePresenter: ViewToPresenterHomeProtocol {
    
    var homeInteractor: PresenterToInteracterHomeProtocol?
    var homeView: PresenterToViewHomeProtocol?
    var filterButton: FilterButton?
    var booksList: [BooksList] = []
    
    // Fetch data books
    func loadBooks(pagination: Int) {
        homeInteractor?.loadAllBooks(pagination: pagination)
    }
    
    // Add to core data
    func addFavoriteBook(_ id: String, _ title: String, _ image: String, _ authorName: String, _ bookDate: String) {
        homeInteractor?.addFavoriteMyBook(id, title, image, authorName, bookDate)
    }
    
    // Delete from core data
    func deleteFavoriteBook(_ id: String) {
        homeInteractor?.deleteFavoriteMyBook(id)
    }
    
    // Fetch data from core data
    func fetchCoreDataList() -> [BooksEntity] {
        return homeInteractor?.fetchCoreDataBooks() ?? []
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    
    func filteredList() {
        switch filterButton {
        case .All:
            self.homeView?.updateData(with: booksList)
        case .NewToOld:
            let sortedBooksList = booksList.sorted {$0.releaseDate! > $1.releaseDate!}
            self.homeView?.updateData(with: sortedBooksList)
        case .OldToNew:
            let sortedBooksList = booksList.sorted {$0.releaseDate! < $1.releaseDate!}
            self.homeView?.updateData(with: sortedBooksList)
        case .Favorites:
            let favoritesList = homeInteractor?.fetchCoreDataBooks()
            if let favoritesList {
                let filteredList = DataTransform.shared.transformBookEntityToBookList(favoritesList)
                self.homeView?.updateData(with: filteredList)
            }
        case .none:
            break
        }
    }
    
    // Data transfer to home view
    func dataTransferToPresenter(with booksList: [BooksList]) {
        self.booksList = booksList
        filteredList()
    }
}

