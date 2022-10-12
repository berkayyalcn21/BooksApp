//
//  Networking.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

protocol NetworkingProtocol {
    func requestData<T: Decodable>(model: T.Type, request: BaseModel, completion: @escaping ((Result<T, Error>) -> Void))
}

class BookNetwork: NetworkingProtocol {
    
    func requestData<T>(model: T.Type, request: BaseModel, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable {
        
        guard let url = URL(string: request.baseUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self else {
                return }
            if error != nil || data == nil {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
