//
//  SearchProductTests.swift
//  Meli1Tests
//
//  Created by Oswaldo Garcia on 13/10/21.
//

import XCTest
import RxSwift
@testable import Meli1



class SearchProductTests: XCTestCase {
    var viewModel : ProductsViewModel!
    var searchProvider : SearchProductProviderProtocol!
    var disposeBag = DisposeBag()
    

    override func setUpWithError() throws {
        searchProvider = SearchProductProviderMock()
        viewModel = ProductsViewModel(provider: searchProvider)
    }

    override func tearDownWithError() throws {
        searchProvider = nil
        viewModel = nil
        
    }

    func testSearchProduct() throws{
        let expectation = expectation(description: "retrieving data...")
        let parameters =  ["q": "Motorola G6","offset":0] as [String : Any]
        viewModel.getProducts(parameters).subscribe(onNext: { results in
            
            XCTAssertTrue(results.products?.count ?? 0 > 0)
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }
    
    func testSearchProduct2() throws{
        let expectation = expectation(description: "retrieving data...")
        
        let query = "Motorola G6"
        
        viewModel.query.onNext(query)
        viewModel.paging.onNext(Paging())
        viewModel.getProducts.onNext(())
        
        
        viewModel.products.subscribe(onNext: { products in
            
            XCTAssertTrue(products.count > 0)
            
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }

}
