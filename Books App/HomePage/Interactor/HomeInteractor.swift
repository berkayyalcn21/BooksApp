//
//  HomeInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class HomeInteractor: PresenterToInteracterHomeProtocol {
    
    var homePresenter: InteractorToPresenterHomeProtocol?
    
    func loadAllBooks() {
        // GET
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/books/top-free/100/books.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                return }
            if error != nil || data == nil {
                self.homePresenter?.dataTransferToPresenter(.failure(NetworkError.NetworkFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Welcome.self, from: data!)
                if let bookList = result.feed?.results {
                    self.homePresenter?.dataTransferToPresenter(.success(bookList))
                }
            }catch {
                self.homePresenter?.dataTransferToPresenter(.failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
}
