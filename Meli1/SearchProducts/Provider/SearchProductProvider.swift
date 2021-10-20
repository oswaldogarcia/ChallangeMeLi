//
//  SearchProductProvider.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 12/10/21.
//

import Foundation
import RxSwift



protocol SearchProductProviderProtocol {
    // This Method will be used to call the service that provide the array of products
    func getProducts(_ parameters: [String : Any]) -> Observable<ResultModel>
}


class SearchProductProvider: SearchProductProviderProtocol {
    
    func getProducts(_ parameters: [String : Any]) -> Observable<ResultModel> {
        return Service.requestService(service: .searchProduct(parameters:parameters), model:ResultModel())
    }
}

// MARK: - Mock Provider
/// Use this class a Mock data of products 
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
