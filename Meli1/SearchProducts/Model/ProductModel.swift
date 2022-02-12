//
//  ProductModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 19/10/21.
//

import Foundation


struct ProductModel: Codable {
    var id, siteID, title: String?
    var price: Int?
    var thumbnail: String?
    var shipping: Shipping?
    var attributes: [Attribute]?
    var installments: Installments?
    
    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title
        case price
        case thumbnail
        case shipping
        case attributes
        case installments
        
    }
}



// MARK: - Attribute
struct Attribute: Codable {
    var  id, name, valueName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case valueName = "value_name"
        
    }
}
// MARK: - Shipping
struct Shipping: Codable {
    var freeShipping: Bool?
    var mode: String?
    var tags: [String]?
    var logisticType: String?
    var storePickUp: Bool?

    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case mode, tags
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }
}
// MARK: - Installments
struct Installments: Codable {
    var quantity: Int?
    var amount: Double?
    var rate: Int?
    var currencyID: String?

    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
}

