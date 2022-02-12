//
//  ProductDetailModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 9/02/22.
//

import Foundation

// MARK: - ProductDetailModel
struct ProductDetailModel: Codable {
    var code: Int?
    var body: ProductDetailBody?
}

// MARK: - ProductDetailBody
struct ProductDetailBody: Codable {
    var id, siteID, title: String?
    var subtitle: String?
    var sellerID: Int?
    var categoryID: String?
    var price, basePrice: Int?
    var condition: String?
    var pictures: [Picture]?
    var attributes: [Attribute]?
    var permalink: String?

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title, subtitle
        case sellerID = "seller_id"
        case categoryID = "category_id"
        case price
        case basePrice = "base_price"
        case condition
        case pictures
        case attributes
        case permalink
    }
}

// MARK: - Picture
struct Picture: Codable {
    var id: String?
    var url: String?
    var secureURL: String?
    var size, maxSize, quality: String?

    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}
