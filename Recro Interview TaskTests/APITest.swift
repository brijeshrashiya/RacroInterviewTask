//
//  APITest.swift
//  Recro Interview TaskTests
//
//  Created by Brijesh on 04/01/23.
//

import XCTest
@testable import Recro_Interview_Task

final class APITest: XCTestCase {

    // Test Mock API
    func test_MockApi_With_ValidRequest_Return_Success() async throws {
        
        let expectation = self.expectation(description: "ValidRequest_Return_Success")
        
        do {
            let obj = try await MockService().getProductList()
            XCTAssertNotNil(obj)
            XCTAssertNotNil(obj.products)
             expectation.fulfill()
            }
        catch {
                print(error)
            }
        
        await waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    // Test Real API - Blackbox Testing
    func test_RealApi_With_ValidRequest_Return_Success() async throws {
        
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
        
        await waitForExpectations(timeout: 5, handler: nil)
        
    }

}
