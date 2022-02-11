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
            
            XCTAssertTrue(results.first?.code == 200)
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }
    
    func testProductDetailValidateFirstAttribute() throws{
        let expectation = expectation(description: "retrieving data...")
        let parameters =  ["ids": "MCO638902957"] as [String : Any]
        viewModel.getProductDetail(parameters).subscribe(onNext: { results in
            
            XCTAssertTrue(results.first?.body?.attributes?.first?.valueName != "")
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 0.1)
        
    }

    func testGetProductDetailWithRxEvents(){
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
