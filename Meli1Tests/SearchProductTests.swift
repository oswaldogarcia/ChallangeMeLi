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
        searchProvider = SearchProductProviderMock() // Using Mock data
        viewModel = ProductsViewModel(provider: searchProvider)
    }

    override func tearDownWithError() throws {
        searchProvider = nil
        viewModel = nil
        
    }
    
    func testCreateParametersFunction() throws {
        
         let query = "Motorola G6"
         let paging = PagingModel(total: 10, primaryResults: 5, offset: 0, limit: 50)
        
        let parameters = viewModel.createParametters(query, paging)
        
        XCTAssertEqual(query, parameters["q"] as! String)
        
        let paramtersOffset = parameters["offset"]
        
        
        let offsetNotEqualExpeting = (paging.offset!) + (paging.limit!)
        /// offsetNotEqualExpeting should be different to paramtersOffset because
        /// in this test paging.offset  plus paging.limit is major than paging.total
        XCTAssertNotEqual(offsetNotEqualExpeting, paramtersOffset as! Int)
        
        let offsetExpeting = (paging.offset!)
        /// offsetExpeting should be equal to paramtersOffset because
        /// in this test paging.offset  plus paging.limit is major than paging.total
        XCTAssertEqual(offsetExpeting, paramtersOffset as! Int)
        
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
    
    func testSearchProductWithRxEvents() throws{
        let expectation = expectation(description: "retrieving data...")
        
        let query = "Motorola G6"
        
        viewModel.query.onNext(query)
        viewModel.paging.onNext(PagingModel())
        viewModel.getProducts.onNext(())
        
        
        viewModel.products.subscribe(onNext: { products in
            
            XCTAssertTrue(products.count > 0)
            
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }

}
