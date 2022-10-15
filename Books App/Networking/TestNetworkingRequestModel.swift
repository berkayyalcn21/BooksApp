//
//  TestNetworkingRequestModel.swift
//  Books App
//
//  Created by Berkay on 15.10.2022.
//

import Foundation

public struct TestNetworkingRequestModel: BaseModel {
    var paginationTotal: Int
    public var baseUrl = ""
    init(paginationTotal: Int) {
        self.paginationTotal = paginationTotal
        self.baseUrl = "https://rss.applemarketingtools.com/api/v2/"
    }
}
