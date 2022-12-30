//
//  APIManager.swift
//  Recro Interview Task
//
//  Created by Brijesh on 29/12/22.
//

import Foundation

class APIManager {
    
    func getProductList() async throws -> ProductResponseModel {
        guard let url = URL(string: "\(ApiConstant.URLs.getProductList)") else { fatalError(StringConstant.APIError.missingURL) }


        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError(StringConstant.APIError.fetchData) }
        

        let decodedData = try JSONDecoder().decode(ProductResponseModel.self, from: data)
        
        return decodedData
    }
    
}
