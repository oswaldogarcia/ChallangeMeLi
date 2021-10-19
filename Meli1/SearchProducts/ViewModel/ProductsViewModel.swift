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


class ProductsViewModel{
    
    var query : AnyObserver<String>!
    var isCalling = BehaviorRelay<Bool>(value: false)
    var products =  BehaviorRelay<[ProductModel]>(value: [])
    var paging : AnyObserver<Paging>!
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
    
        let _paging = BehaviorSubject<Paging>(value: Paging())
        self.paging = _paging.asObserver()

        let val = Observable.combineLatest(_query,_paging){ query ,paging in (query , paging)}
        
        self.getProductsResult = _getProducts
            .withLatestFrom(val)
            .flatMapLatest{ (query,paging) -> Observable<ResultModel> in
                
                
                let parameters =  self.createParametters(query, paging)

                return self.getProducts(parameters)
                
            }
        
        
        
        self.subscribeData()
        
  }
    
    
    
     func getProducts(_ parameters:[String : Any])  -> Observable<ResultModel>  {
        
        return productsProvider.getProducts(parameters)
     }
    
    
    func subscribeData()  {
        
        self.getProductsResult.subscribe( onNext: { [weak self] (results) in
            let offset = results.paging?.offset ?? 0
            if offset > 0 {
                var products = self?.products.value
                products! += results.products ?? []
                self?.products.accept(products ?? [])
            }else{
                self?.products.accept(results.products ?? [])
            }
            self?.paging.onNext(results.paging ?? Paging())
            self?.isCalling.accept(false)
        }).disposed(by: self.disposeBag)
    }
    
    
    
    private func createParametters(_ query:String, _ paging:Paging) -> [String : Any]{
        
                var offset = 0
        
                if (paging.offset ?? 0) + (paging.limit ?? 0) >= (paging.total ?? 0){
                    offset = (paging.offset ?? 0) // no mas
        
                }else{
                    offset = (paging.offset ?? 0) + (paging.limit ?? 0)
                }
                print("offset:", offset)
        
                return  ["q": query,"offset":offset] as [String : Any]
        
    }
    
    
//    func searchProduct(){
//
//        let query = self.query.value
//
//        var offset = 0
//
//        if (self.paging.value.offset ?? 0) + (self.paging.value.limit ?? 0) >= (self.paging.value.total ?? 0){
//            offset = (self.paging.value.offset ?? 0) // no mas
//
//        }else{
//            offset = (self.paging.value.offset ?? 0) + (self.paging.value.limit ?? 0)
//        }
//        print("offset:", offset)
//
//        let parameters =  ["q": query,"offset":offset] as [String : Any]
//
//
//
//        self.products.accept([])
//        if query != ""{
//            self.getProducts(parameters).subscribe( onNext: { [weak self] (results) in
//                if offset > 0{
//                    var products = self?.products.value
//                    products! += results.products ?? []
//                    self?.products.accept(products ?? [])
//
//                }else{
//                    self?.products.accept(results.products ?? [])
//                }
//                self?.paging.accept(results.paging ?? Paging())
//            }).disposed(by: self.disposeBag)
//        }
//
//    }
   
}
