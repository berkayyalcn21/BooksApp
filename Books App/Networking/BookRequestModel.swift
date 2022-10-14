//
//  BookRequestModel.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

public struct BookRequestModel: BaseModel {
    var paginationTotal: Int
    public var baseUrl = ""
    init(paginationTotal: Int) {
        self.paginationTotal = paginationTotal
        self.baseUrl = "https://rss.applemarketingtools.com/api/v2/us/books/top-free/\(paginationTotal)/books.json"
    }
}
