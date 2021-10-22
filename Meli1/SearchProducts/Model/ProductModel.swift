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
    
    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title
        case price
        case thumbnail
        case shipping
        case attributes
        
    }
}



// MARK: - Attribute
struct Attribute: Codable {
    var valueID, attributeGroupName: String?
    var source: Int?
    var attributeGroupID, id, name, valueName: String?
    var values: [Value]?

    enum CodingKeys: String, CodingKey {
        case valueID = "value_id"
        case attributeGroupName = "attribute_group_name"
        case source
        case attributeGroupID = "attribute_group_id"
        case id, name
        case valueName = "value_name"
        case values
    }
}

// MARK: - Value
struct Value: Codable {
    
    var source: Int?
    var id, name: String?

    enum CodingKeys: String, CodingKey {
        
        case source, id, name
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
