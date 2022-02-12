//
//  SearchProductProviderMock.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 11/02/22.
//

import Foundation
import RxSwift



// MARK: - Mock Products Provider
/// Use this class to get Mock data of products
class SearchProductProviderMock: SearchProductProviderProtocol {
    
    func getProducts(_ parameters: [String : Any]) -> Observable<ResultModel> {
        return Helpers.shared.getObservableModelFromLocalJSON(jsonName: "ProductsMock", model: ResultModel())
    }
}
