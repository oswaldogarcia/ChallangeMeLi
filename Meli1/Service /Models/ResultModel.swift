//
//  ResultModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 11/10/21.
//

import Foundation

// MARK: - Result
struct ResultModel: Codable {
    
    var products: [ProductModel]?
    var paging: Paging?


    enum CodingKeys: String, CodingKey {
        case products = "results"
        case paging
        
    }
}

// MARK: - Paging
struct Paging: Codable {
    var total, primaryResults, offset, limit: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case primaryResults = "primary_results"
        case offset, limit
    }
}

