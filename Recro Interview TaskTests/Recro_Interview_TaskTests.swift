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
     var productVM : ProductViewModel!
    var cancellables : Set<AnyCancellable>!
    
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
        productVM
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

}
