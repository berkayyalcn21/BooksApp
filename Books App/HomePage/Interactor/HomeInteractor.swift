//
//  HomeInteractor.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


class HomeInteractor: PresenterToInteracterHomeProtocol {
    
    var homePresenter: InteractorToPresenterHomeProtocol?
    
    func loadAllBooks(pagination: Int) {
        BookNetwork().requestData(model: Welcome.self, request: BookRequestModel) { result in
            switch result {
            case .success(let success):
                self.homePresenter?.dataTransferToPresenter(with: [success])
            case .failure(_):
                break
            }
        }
    }
    
    
    
    
    
    
//    func loadAllBooks(pagination: Int) {
//        // GET
//        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/books/top-free/\(pagination)/books.json") else {
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let self = self else {
//                return }
//            if error != nil || data == nil {
//                self.homePresenter?.dataTransferToPresenter(.failure(NetworkError.NetworkFailed))
//                return
//            }
//
//            do {
//                let result = try JSONDecoder().decode(Welcome.self, from: data!)
//                if let bookList = result.feed?.results {
//                    self.homePresenter?.dataTransferToPresenter(.success(bookList))
//                }
//            }catch {
//                self.homePresenter?.dataTransferToPresenter(.failure(NetworkError.ParsingFailed))
//            }
//        }
//        task.resume()
//    }
}
