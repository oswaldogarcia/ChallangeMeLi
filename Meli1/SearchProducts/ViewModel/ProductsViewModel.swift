//
//  ProductsViewModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 12/10/21.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

/// `ProductsViewModel`
/// This class manage the logic between the Products list view and the ProductModel
class ProductsViewModel {
    
    var query : AnyObserver<String>!
    var isCalling = BehaviorRelay<Bool>(value: false)
    var endOfResults = BehaviorRelay<Bool>(value: false)
    var products =  BehaviorRelay<[ProductModel]>(value: [])
    var paging : AnyObserver<PagingModel>!
    var getProducts : AnyObserver<Void>!
    var getProductsResult : Observable<ResultModel>!
    var disposeBag = DisposeBag()
    
    private var productsProvider : SearchProductProviderProtocol
   
    
    init(provider : SearchProductProviderProtocol = SearchProductProvider()){
        
        self.productsProvider = provider

        let _getProducts = PublishSubject<Void>()
        self.getProducts = _getProducts.asObserver()
    
        let _query = BehaviorSubject<String>(value: "")
        self.query = _query.asObserver()
    
        let _paging = BehaviorSubject<PagingModel>(value: PagingModel())
        self.paging = _paging.asObserver()

        let val = Observable.combineLatest(_query,_paging){ query ,paging in (query , paging)}
        
        self.getProductsResult = _getProducts
            .withLatestFrom(val)
            .flatMapLatest{ (query,paging) -> Observable<ResultModel> in
                UIApplication.shared.activityStartAnimating()
                let parameters =  self.createParametters(query, paging)
                return self.getProducts(parameters)
            }
        
        self.subscribeData()
  }
    
    
    ///This function get Products using the method of the provider protocol
     func getProducts(_ parameters:[String : Any])  -> Observable<ResultModel>  {
        return productsProvider.getProducts(parameters)
     }
    
    ///Subscription of the  Observables
    func subscribeData()  {
        
        /// Subscribig to the result of get product and set the results
        self.getProductsResult.subscribe( onNext: { [weak self] (result) in
            UIApplication.shared.activityStopAnimating()
            if result.products?.count ?? 0 > 0 {
                
                let offset = result.paging?.offset ?? 0
                if offset > 0 {
                    var products = self?.products.value
                    products! += result.products ?? []
                    self?.products.accept(products ?? [])
                }else{
                    self?.products.accept(result.products ?? [])
                }
                self?.paging.onNext(result.paging ?? PagingModel())
                self?.isCalling.accept(false)
                if offset + (result.paging?.limit ?? 0) >= (result.paging?.total ?? 0){
                    self?.endOfResults.accept(true)
                }
            }else{
                UIApplication.shared.showErrorAlert("No se encotró el producto que estas buscando." , title: "Lo sentimos!")
                self?.products.accept([])
            }
        }).disposed(by: self.disposeBag)
    }
    
    
    /// This function create the parameters Dictionary to search the product
    /// according to the query and the offset for pagination
    ///
    /// - Parameter query: String with the value of the user query
    /// - Parameter pagin: PagingModel object to manage the offset of the request
    ///                    and the pagination
    func createParametters(_ query:String, _ paging:PagingModel) -> [String : Any]{
        
                var offset = 0
        
                if (paging.offset ?? 0) + (paging.limit ?? 0) >= (paging.total ?? 0){
                    offset = (paging.offset ?? 0) 
                }else{
                    offset = (paging.offset ?? 0) + (paging.limit ?? 0)
                }
                return  ["q": query,"offset":offset] as [String : Any]
        
    }
    

}
