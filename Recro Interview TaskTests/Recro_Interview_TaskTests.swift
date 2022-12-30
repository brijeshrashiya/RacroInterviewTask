//
//  Recro_Interview_TaskTests.swift
//  Recro Interview TaskTests
//
//  Created by Brijesh on 29/12/22.
//

import XCTest
@testable import Recro_Interview_Task

final class Recro_Interview_TaskTests: XCTestCase {

    func test_Api_With_ValidRequest_Return_Success() async {
        
        let expectation = self.expectation(description: "ValidRequest_Return_Success")
        
        do {
            let obj = try await APIManager().getProductList()
            XCTAssertNotNil(obj)
            XCTAssertNotNil(obj.products)
             expectation.fulfill()
            }
        catch {
                print(error)
            }
        
        await waitForExpectations(timeout: 30, handler: nil)
        
    }

}
