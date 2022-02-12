//
//  ProductDetailProviderMock.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 10/02/22.
//

import Foundation
import RxSwift

// MARK: - Product Detail Provider Mock
/// Use this class to get Mock data of product detail
class GetProductProviderMock: ProductDetailProviderProtocol {
    
    func getProductDetail(_ parameters: [String : Any]) -> Observable<[ProductDetailModel]> {
        return Helpers.shared.getObservableModelFromLocalJSON(jsonName: "ProductDetailMock", model: [ProductDetailModel()])
    }
}
