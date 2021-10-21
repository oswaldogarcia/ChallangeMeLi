//
//  SearchProductProvider.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 12/10/21.
//

import Foundation
import RxSwift


// MARK: - Products Provider Protocol
/// `SearchProductProviderProtocol`
/// This procol contains the necesary method to get products

protocol SearchProductProviderProtocol {
    
    /// This Method will be used to call the service that provide
    /// the array of products.
    ///
    /// Usage:
    ///
    ///     productsProvider.getProducts(parameters)
    ///
    /// - Parameter parameters: A Dictionary `[String : Any]`.
    ///
    ///     Example :
    ///     let parameters =  ["q": "Motorola G6","offset":0] as [String : Any]
    ///
    /// - Returns: A `Observable<ResultModel>` with the data of the request.
    func getProducts(_ parameters: [String : Any]) -> Observable<ResultModel>
}

// MARK: - Products Provider
/// Use this class to get real data of products
class SearchProductProvider: SearchProductProviderProtocol {
    
    func getProducts(_ parameters: [String : Any]) -> Observable<ResultModel> {
        return Service.requestService(service: .searchProduct(parameters:parameters), model:ResultModel())
    }
}

// MARK: - Mock Products Provider
/// Use this class to get Mock data of products
class SearchProductProviderMock: SearchProductProviderProtocol {
    
    func getProducts(_ parameters: [String : Any]) -> Observable<ResultModel> {
        
        return Observable<ResultModel>.create { (observer) -> Disposable in
            
            let url = Bundle.main.url(forResource: "ProductsMock", withExtension: "json")
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try Data(contentsOf: url!)
                let model = try decoder.decode(ResultModel.self, from: jsonData)
                observer.onNext(model)
            }catch let error{
                observer.onError(error)
            }
            
            return Disposables.create {}
        }
        
    }
}
