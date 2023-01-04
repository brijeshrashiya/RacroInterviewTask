//
//  MockService.swift
//  Recro Interview TaskTests
//
//  Created by Brijesh on 04/01/23.
//

import Foundation
@testable import Recro_Interview_Task

class MockService : HTTPProtocol, Mockable {
    
    func getProductList() async throws -> ProductResponseModel {
        return loadJson(fileName: "ProductListResponse", type: ProductResponseModel.self)
    }
}


protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJson<T: Decodable>(fileName: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJson<T: Decodable>(fileName: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Failed to load JSON file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        }
        catch {
            print("❌ \(error)")
            fatalError("Failed to decode the JSON.")
        }
    }
}
