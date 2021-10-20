//
//  ProductModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 19/10/21.
//

import Foundation


struct ProductModel: Codable {
    var id, siteID, title: String?
//    var seller: Seller?
     var price: Int?
//    var prices: Prices?
//    var salePrice: Int?
//    var currencyID: String?
//    var availableQuantity, soldQuantity: Int?
//    var buyingMode, listingTypeID, stopTime, condition: String?
//    var permalink: String?
    var thumbnail: String?
//    var thumbnailID: String?
//    var acceptsMercadopago: Bool?
//    var installments: Installments?
//    var address: Address?
    var shipping: Shipping?
//    var sellerAddress: SellerAddress?
    var attributes: [Attribute]?
//    var differentialPricing: DifferentialPricing?
//    var originalPrice: Int?
//    var categoryID: String?
//    var officialStoreID: String?
//    var domainID, catalogProductID: String?
//    var tags: [String]?
//    var orderBackend: Int?
//    var useThumbnailID: Bool?
//

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title
        case price
//        case seller, price, prices
//        case salePrice = "sale_price"
//        case currencyID = "currency_id"
//        case availableQuantity = "available_quantity"
//        case soldQuantity = "sold_quantity"
//        case buyingMode = "buying_mode"
//        case listingTypeID = "listing_type_id"
//        case stopTime = "stop_time"
//        case condition, permalink,
        case thumbnail
//        case thumbnailID = "thumbnail_id"
//        case acceptsMercadopago = "accepts_mercadopago"
//        case installments, address,
        case shipping
//        case sellerAddress = "seller_address"
        case attributes
//        case differentialPricing = "differential_pricing"
//        case originalPrice = "original_price"
//        case categoryID = "category_id"
//        case officialStoreID = "official_store_id"
//        case domainID = "domain_id"
//        case catalogProductID = "catalog_product_id"
//        case tags
//        case orderBackend = "order_backend"
//        case useThumbnailID = "use_thumbnail_id"
        
    }
}

// MARK: - Address
struct Address: Codable {
    var stateID, stateName, cityID, cityName: String?

    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
        case cityID = "city_id"
        case cityName = "city_name"
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

// MARK: - DifferentialPricing
struct DifferentialPricing: Codable {
    var id: Int?
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

// MARK: - Prices
struct Prices: Codable {
    var id: String?
    var prices: [Price]?
    var presentation: Presentation?
   
    var referencePrices: [ReferencePrice]?
   

    enum CodingKeys: String, CodingKey {
        case id, prices, presentation
        
        case referencePrices = "reference_prices"
        
    }
}

// MARK: - Presentation
struct Presentation: Codable {
    var displayCurrency: String?

    enum CodingKeys: String, CodingKey {
        case displayCurrency = "display_currency"
    }
}

// MARK: - Price
struct Price: Codable {
    var id, type: String?
    var amount: Int?
    var regularAmount: Int?
    var currencyID: String?
    var lastUpdated: Date?
    var conditions: Conditions?
    var exchangeRateContext: String?
    var metadata: Metadata?

    enum CodingKeys: String, CodingKey {
        case id, type, amount
        case regularAmount = "regular_amount"
        case currencyID = "currency_id"
        case lastUpdated = "last_updated"
        case conditions
        case exchangeRateContext = "exchange_rate_context"
        case metadata
    }
}

// MARK: - Conditions
struct Conditions: Codable {
    var contextRestrictions: [String]?
    var startTime, endTime: Date?
    var eligible: Bool?

    enum CodingKeys: String, CodingKey {
        case contextRestrictions = "context_restrictions"
        case startTime = "start_time"
        case endTime = "end_time"
        case eligible
    }
}

// MARK: - Metadata
struct Metadata: Codable {
}

// MARK: - ReferencePrice
struct ReferencePrice: Codable {
    var id, type: String?
    var conditions: Conditions?
    var amount: Int?
    var currencyID, exchangeRateContext: String?
   
    var lastUpdated: Date?

    enum CodingKeys: String, CodingKey {
        case id, type, conditions, amount
        case currencyID = "currency_id"
        case exchangeRateContext = "exchange_rate_context"
        case lastUpdated = "last_updated"
    }
}

// MARK: - Seller
struct Seller: Codable {
    var id: Int?
    var permalink: String?
    var registrationDate: String?
    var carDealer, realEstateAgency: Bool?
    var tags: [String]?
    var sellerReputation: SellerReputation?

    enum CodingKeys: String, CodingKey {
        case id, permalink
        case registrationDate = "registration_date"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
        case tags
        case sellerReputation = "seller_reputation"
    }
}

// MARK: - SellerReputation
struct SellerReputation: Codable {
    var powerSellerStatus: Int?
    var realLevel, levelID, protectionEndDate: String?
    var metrics: Metrics?
    var transactions: Transactions?

    enum CodingKeys: String, CodingKey {
        case powerSellerStatus = "power_seller_status"
        case realLevel = "real_level"
        case levelID = "level_id"
        case protectionEndDate = "protection_end_date"
        case metrics, transactions
    }
}

// MARK: - Metrics
struct Metrics: Codable {
    var cancellations, claims, delayedHandlingTime: Cancellations?
    var sales: Sales?

    enum CodingKeys: String, CodingKey {
        case cancellations, claims
        case delayedHandlingTime = "delayed_handling_time"
        case sales
    }
}

// MARK: - Cancellations
struct Cancellations: Codable {
    var excluded: Excluded?
    var period: String?
    var rate, value: Int?
}

// MARK: - Excluded
struct Excluded: Codable {
    var realValue: Int?
    var realRate: Double?

    enum CodingKeys: String, CodingKey {
        case realValue = "real_value"
        case realRate = "real_rate"
    }
}

// MARK: - Sales
struct Sales: Codable {
    var period: String?
    var completed: Int?
}

// MARK: - Transactions
struct Transactions: Codable {
    var canceled: Int?
    var period: String?
    var total: Int?
    var ratings: Ratings?
    var completed: Int?
}

// MARK: - Ratings
struct Ratings: Codable {
    var negative, neutral, positive: Double?
}

// MARK: - SellerAddress
struct SellerAddress: Codable {
    var id, comment, addressLine, zipCode: String?
    var country, state, city: City?
    var latitude, longitude: String?

    enum CodingKeys: String, CodingKey {
        case id, comment
        case addressLine = "address_line"
        case zipCode = "zip_code"
        case country, state, city, latitude, longitude
    }
}

// MARK: - City
struct City: Codable {
    var id, name: String?
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
