//
//  GetProductDetailTests.swift
//  Meli1Tests
//
//  Created by Oswaldo Garcia on 10/02/22.
//

import XCTest
import RxSwift
@testable import Meli1

class GetProductDetailTests: XCTestCase {
    var viewModel : ProductDetailViewModel!
    var productDetailProvider : ProductDetailProviderProtocol!
    var disposeBag = DisposeBag()
    

    override func setUpWithError() throws {
        productDetailProvider = GetProductProviderMock() // Using Mock data
        viewModel = ProductDetailViewModel(provider: productDetailProvider)
    }

    override func tearDownWithError() throws {
        productDetailProvider = nil
        viewModel = nil
        
    }
    
    
    
    func testGetProductDetail() throws{
        let expectation = expectation(description: "retrieving data...")
        let parameters =  ["ids": "MCO638902957"] as [String : Any]
        viewModel.getProductDetail(parameters).subscribe(onNext: { results in
            
            /// if the code is equal to 200 means that we get the product detail successful
            XCTAssertEqual(results.first?.code, 200)
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }
    
    func testProductDetailValidateNeededData() throws{
        let expectation = expectation(description: "retrieving data...")
        let parameters =  ["ids": "MCO638902957"] as [String : Any]
        viewModel.getProductDetail(parameters).subscribe(onNext: { results in
            
            ///the next values should not be null,to guarantee the information show good in the view
            
            /// Tittle
            XCTAssertNotNil(results.first?.body?.title)
            /// image
            XCTAssertNotNil(results.first?.body?.pictures?.first)
            /// price
            XCTAssertNotNil(results.first?.body?.price)
            /// attributes
            XCTAssertNotNil(results.first?.body?.attributes?.first)
            
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }

    func testGetProductDetailUsingRxEvents(){
        let expectation = expectation(description: "retrieving data...")
        
        let productId = "MCO638902957"
        
        viewModel.poductId.onNext(productId)
        viewModel.getProduct.onNext(())
        
        
        viewModel.product.subscribe(onNext: { response in
            
            XCTAssertEqual(response.id, productId)
            
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }

    
}
