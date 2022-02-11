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
        
        return Observable<[ProductDetailModel]>.create { (observer) -> Disposable in
            
            let url = Bundle.main.url(forResource: "ProductDetailMock", withExtension: "json")
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try Data(contentsOf: url!)
                let model = try decoder.decode(ProductDetailModel.self, from: jsonData)
                observer.onNext([model])
            }catch let error{
                observer.onError(error)
            }
            
            return Disposables.create {}
        }
        
    }
}
