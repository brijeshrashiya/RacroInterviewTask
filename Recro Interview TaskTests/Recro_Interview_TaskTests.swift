//
//  Recro_Interview_TaskTests.swift
//  Recro Interview TaskTests
//
//  Created by Brijesh on 29/12/22.
//

import Combine
import XCTest
@testable import Recro_Interview_Task

final class Recro_Interview_TaskTests: XCTestCase {
     var productVM : ProductViewModel?
    var cancellables : Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        productVM = ProductViewModel(service: MockService())
        cancellables = []

    }
    override func tearDown() {
        super.tearDown()
        productVM = nil
        cancellables = []
    }

    func test_Api_With_ValidRequest_Return_Success() async throws {
        
        let expectation = self.expectation(description: "ValidRequest_Return_Success")
        productVM?
            .$productData
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertNotNil(value)
                XCTAssertEqual(value.count, 21)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        await waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func test_Api_With_ValidId_Return_Success() async throws {
        
        let expectation = self.expectation(description: "ValidId_Return_Success")
        productVM?
            .$productData
            .dropFirst()
            .sink(receiveValue: { value in
                
                for i in 0..<value.count {
                    let item = value[i]
                    XCTAssertNotNil(item.id)
                    XCTAssertTrue((item.id?.count ?? 0) > 0, "Product id is empty at \(i)")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        await waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func test_Api_With_ValidTitle_Return_Success() async throws {
        
        let expectation = self.expectation(description: "ValidTitle_Return_Success")
        productVM?
            .$productData
            .dropFirst()
            .sink(receiveValue: { value in
                
                for i in 0..<value.count {
                    let item = value[i]
                    XCTAssertNotNil(item.title)
                    XCTAssertTrue((item.title?.count ?? 0) > 0, "Product title is empty at \(i)")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        await waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func test_Api_With_ValidPrice_Return_Success() async throws {
        
        let expectation = self.expectation(description: "ValidPrice_Return_Success")
        productVM?
            .$productData
            .dropFirst()
            .sink(receiveValue: { value in
                
                for i in 0..<value.count {
                    let item = value[i]
                    XCTAssertNotNil(item.price)
                    XCTAssertTrue((item.price?.count ?? 0) > 0, "Product price is empty at \(i)")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        await waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func test_Api_With_ValidImage_Return_Success() async throws {
        
        let expectation = self.expectation(description: "ValidImage_Return_Success")
        productVM?
            .$productData
            .dropFirst()
            .sink(receiveValue: { value in
                
                for i in 0..<value.count {
                    let item = value[i]
                    XCTAssertNotNil(item.imageURL)
                    XCTAssertTrue((item.imageURL?.count ?? 0) > 0, "Product image is empty at \(i)")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        await waitForExpectations(timeout: 5, handler: nil)
        
    }

}
