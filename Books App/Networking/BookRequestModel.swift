//
//  BookRequestModel.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

public protocol BaseModel: Codable {
    
    var baseUrl: String {get set}
}

public struct BookRequestModel: BaseModel {
    
    public var baseUrl = "https://rss.applemarketingtools.com/api/v2/us/books/top-free/20/books.json"
}
