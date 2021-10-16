//
//  ProductsViewModel.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 12/10/21.
//

import Foundation
import RxSwift
import RxCocoa


class ProductsViewModel{
    
    deinit {
        print("ProductsViewModel deinit")
    }
    
    private var productsProvider : SearchProductProviderProtocol
   
    
    init(provider : SearchProductProviderProtocol = SearchProductProvider()){
        self.productsProvider = provider
    }
    
     func getProducts(_ q:String)  -> Observable<[ResultModel]>  {
        
        return productsProvider.getProducts(q)
        
     }
   
}
