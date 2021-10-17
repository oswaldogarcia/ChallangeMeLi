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
    
    var query = BehaviorRelay<String>(value: "")
    var products = BehaviorRelay<[ResultModel]>(value: [])
    var disposeBag = DisposeBag()
    
    private var productsProvider : SearchProductProviderProtocol
   
    
    init(provider : SearchProductProviderProtocol = SearchProductProvider()){
        self.productsProvider = provider
    }
    
     func getProducts(_ q:String)  -> Observable<[ResultModel]>  {
        let parameters =  ["q": q,"offset":50] as [String : Any]
        return productsProvider.getProducts(parameters)
     }
    
    func searchProduct(){
        
        let query = self.query.value
        
        self.products.accept([])
        if query != ""{
            self.getProducts(query).subscribe( onNext: { [weak self] (products) in
                self?.products.accept(products)
            }).disposed(by: self.disposeBag)
        }
        
    }
   
}
