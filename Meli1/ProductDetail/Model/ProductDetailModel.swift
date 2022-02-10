//
//  ProductDetailModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 9/02/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productDetailModel = try? newJSONDecoder().decode(ProductDetailModel.self, from: jsonData)

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
   // var officialStoreID: String?
    var price, basePrice: Int?
//    var originalPrice: JSONNull?
//    var currencyID: String?
//    var initialQuantity, availableQuantity, soldQuantity: Int?
//    var saleTerms: [Attribute]?
//    var buyingMode, listingTypeID, startTime, stopTime: String?
//    var condition: String?
//    var permalink: String?
//    var thumbnailID: String?
//    var thumbnail: String?
//    var secureThumbnail: String?
    var pictures: [Picture]?
//    var videoID: JSONNull?
//    var descriptions: [JSONAny]?
//    var acceptsMercadopago: Bool?
//    var nonMercadoPagoPaymentMethods: [JSONAny]?
//    var shipping: Shipping?
//    var internationalDeliveryMode: String?
//    var sellerAddress: SellerAddress?
//    var sellerContact: JSONNull?
//    var location: Location?
//    var coverageAreas: [JSONAny]?
//    var attributes: [Attribute]?
//    var warnings: [JSONAny]?
//    var listingSource: String?
//    var variations: [JSONAny]?
//    var status: String?
//    var subStatus: [JSONAny]?
//    var tags: [String]?
//    var warranty, catalogProductID, domainID: String?
//    var parentItemID, differentialPricing: JSONNull?
//    var dealIDS: [JSONAny]?
//    var automaticRelist: Bool?
//    var dateCreated, lastUpdated: String?
//    var health: JSONNull?
//    var catalogListing: Bool?
//    var channels: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title, subtitle
        case sellerID = "seller_id"
        case categoryID = "category_id"
        //case officialStoreID = "official_store_id"
        case price
        case basePrice = "base_price"
//        case originalPrice = "original_price"
//        case currencyID = "currency_id"
//        case initialQuantity = "initial_quantity"
//        case availableQuantity = "available_quantity"
//        case soldQuantity = "sold_quantity"
//        case saleTerms = "sale_terms"
//        case buyingMode = "buying_mode"
//        case listingTypeID = "listing_type_id"
//        case startTime = "start_time"
//        case stopTime = "stop_time"
//        case condition, permalink
//        case thumbnailID = "thumbnail_id"
//        case thumbnail
//        case secureThumbnail = "secure_thumbnail"
        case pictures
//        case videoID = "video_id"
//        case descriptions
//        case acceptsMercadopago = "accepts_mercadopago"
//        case nonMercadoPagoPaymentMethods = "non_mercado_pago_payment_methods"
//        case shipping
//        case internationalDeliveryMode = "international_delivery_mode"
//        case sellerAddress = "seller_address"
//        case sellerContact = "seller_contact"
//        case location
//        case coverageAreas = "coverage_areas"
//        case attributes, warnings
//        case listingSource = "listing_source"
//        case variations
//        case status
//        case subStatus = "sub_status"
//        case tags, warranty
//        case catalogProductID = "catalog_product_id"
//        case domainID = "domain_id"
//        case parentItemID = "parent_item_id"
//        case differentialPricing = "differential_pricing"
//        case dealIDS = "deal_ids"
//        case automaticRelist = "automatic_relist"
//        case dateCreated = "date_created"
//        case lastUpdated = "last_updated"
//        case health
//        case catalogListing = "catalog_listing"
//        case channels
    }
}

//// MARK: - Attribute
//struct Attribute: Codable {
//    var id, name: String?
//    var valueID: String?
//    var valueName: String?
//    var valueStruct: Struct?
//    var values: [Value]?
//    var attributeGroupID: AttributeGroupID?
//    var attributeGroupName: AttributeGroupName?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case valueID = "value_id"
//        case valueName = "value_name"
//        case valueStruct = "value_struct"
//        case values
//        case attributeGroupID = "attribute_group_id"
//        case attributeGroupName = "attribute_group_name"
//    }
//}

enum AttributeGroupID: String, Codable {
    case others = "OTHERS"
}

enum AttributeGroupName: String, Codable {
    case otros = "Otros"
}

// MARK: - Struct
struct Struct: Codable {
    var number: Double?
    var unit: String?
}

// MARK: - Value
//struct Value: Codable {
//    var id: String?
//    var name: String?
//    var valueStruct: Struct?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case valueStruct = "struct"
//    }
//}

// MARK: - Location
struct Location: Codable {
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

// MARK: - SellerAddress
struct SellerAddress: Codable {
    var city, state, country: City?
    var searchLocation: SearchLocation?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case city, state, country
        case searchLocation = "search_location"
        case id
    }
}

// MARK: - City
struct City: Codable {
    var id, name: String?
}

// MARK: - SearchLocation
struct SearchLocation: Codable {
    var neighborhood, city, state: City?
}

// MARK: - Shipping
//struct Shipping: Codable {
//    var mode: String?
//    var freeMethods: [FreeMethod]?
//    var tags: [String]?
//    var dimensions: JSONNull?
//    var localPickUp, freeShipping: Bool?
//    var logisticType: String?
//    var storePickUp: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case mode
//        case freeMethods = "free_methods"
//        case tags, dimensions
//        case localPickUp = "local_pick_up"
//        case freeShipping = "free_shipping"
//        case logisticType = "logistic_type"
//        case storePickUp = "store_pick_up"
//    }
//}

// MARK: - FreeMethod
struct FreeMethod: Codable {
    var id: Int?
    var rule: Rule?
}

// MARK: - Rule
struct Rule: Codable {
    var ruleDefault: Bool?
    var freeMode: String?
    var freeShippingFlag: Bool?
//    var value: JSONNull?

    enum CodingKeys: String, CodingKey {
        case ruleDefault = "default"
        case freeMode = "free_mode"
        case freeShippingFlag = "free_shipping_flag"
//        case value
    }
}

