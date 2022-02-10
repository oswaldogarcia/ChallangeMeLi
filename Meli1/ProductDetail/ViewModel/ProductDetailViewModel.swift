//
//  ProductDetailViewModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 9/02/22.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

/// `ProductsViewModel`
/// This class manage the logic between the Products list view and the ProductModel
class ProductDetailViewModel {
    
    var poductId : AnyObserver<String>!
//    var isCalling = BehaviorRelay<Bool>(value: false)
//    var endOfResults = BehaviorRelay<Bool>(value: false)
    var product =  BehaviorRelay<ProductDetailBody>(value:ProductDetailBody())
//    var paging : AnyObserver<PagingModel>!
    var getProduct : AnyObserver<Void>!
    var getProductDetailResult : Observable<[ProductDetailModel]>!
    var disposeBag = DisposeBag()
    
    private var productDetailProvider : ProductDetailProviderProtocol
   
    
    init(provider : ProductDetailProviderProtocol = GetProductProvider()){
        
        productDetailProvider = provider

        let _getProduct = PublishSubject<Void>()
        self.getProduct = _getProduct.asObserver()
    
        let _productId = BehaviorSubject<String>(value: "")
        self.poductId = _productId.asObserver()

        self.getProductDetailResult = Observable.concat(_getProduct)
            .withLatestFrom(_productId)
            .flatMapLatest{ (productId) -> Observable<[ProductDetailModel]> in
            
                let parameters =  self.createParameters(productId)

                return self.getProductDetail(parameters)
                
            }
        
        self.subscribeData()
  }
    
    
    ///This function get Products using the method of the provider protocol
     func getProductDetail(_ parameters:[String : Any])  -> Observable<[ProductDetailModel]>  {
        return productDetailProvider.getProductDetail(parameters)
     }
    
    ///Subscription of the  Observables
    func subscribeData()  {
        
        /// Subscribig to the result of get product and set the results
        self.getProductDetailResult.subscribe( onNext: { [weak self] (result) in
            
            print(result.first?.code)
           
            self?.product.accept(result.first?.body ?? ProductDetailBody())
            
        }).disposed(by: self.disposeBag)
    }
    
    
    /// This function create the parameters Dictionary to search the product
    /// according to the query and the offset for pagination
    ///
    /// - Parameter query: String with the value of the user query
    /// - Parameter pagin: PagingModel object to manage the offset of the request
    ///                    and the pagination
    func createParameters(_ id:String) -> [String : Any]{
                return  ["ids": id] as [String : Any]
    }
    

}
