//
//  RequestModel.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation

public protocol BaseModel: Codable {
    
    var baseUrl: String {get set}
}
