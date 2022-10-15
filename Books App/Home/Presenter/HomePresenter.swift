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
    
    // Transform data string to date
    func stringToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: string)
        dateFormatter.string(from: date ?? .now)
        return date ?? .now
    }
    
    // Data transform for home page filter
    func makeTransformToFavorites(_ booksEntity: [BooksEntity]) -> [BooksList] {
        let booksList: [BooksList] = booksEntity.map {
            let date = self.stringToDate($0.bookDate ?? "")
            return BooksList(artistName: $0.authorName, id: $0.id, name: $0.title, releaseDate: date, artworkUrl100: $0.bookImage) }
        return booksList
    }
    
    // Data transfer to home view
    func dataTransferToPresenter(with booksList: [BooksList]) {
        switch filterButton {
        case .All:
            self.homeView?.updateData(with: booksList)
        case .NewToOld:
            let sortedBooksList = booksList.sorted {$0.releaseDate! > $1.releaseDate!}
            print(sortedBooksList.count)
            self.homeView?.updateData(with: sortedBooksList)
        case .OldToNew:
            let sortedBooksList = booksList.sorted {$0.releaseDate! < $1.releaseDate!}
            print(sortedBooksList.count)
            self.homeView?.updateData(with: sortedBooksList)
        case .Favorites:
            let favoritesList = homeInteractor?.fetchCoreDataBooks()
            if let favoritesList {
                let filteredList = makeTransformToFavorites(favoritesList)
                self.homeView?.updateData(with: filteredList)
            }
        case .none:
            break
        }
    }
}

