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
        viewModel.getProducts("iphone").subscribe(onNext: { products in
            
            XCTAssertTrue(products.count > 0)
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }

}
