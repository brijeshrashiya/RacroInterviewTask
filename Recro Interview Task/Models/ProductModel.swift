//
//  ProductModel.swift
//  Recro Interview Task
//
//  Created by Brijesh on 29/12/22.
//

import Foundation

struct ProductResponseModel: Decodable {
    var products: [ProductModel]?
}


struct ProductModel: Decodable, Equatable {
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var citrusId: String?
    var title: String?
    var id:String?
    var imageURL: String?
    var isFavourite:Bool? = false
    var brand: String?
    var ratingCount: Double?
    var isAddToCartEnable: Bool?
    var addToCartButtonText: String?
    var isInTrolley: Bool?
    var isInWishlist: Bool?
    var isFindMeEnable: Bool?
    var saleUnitPrice: Double?
    var totalReviewCount: Int?
    var isDeliveryOnly: Bool?
    var isDirectFromSupplier: Bool?
    
    var price: [PriceModel]?
    var badges: [String]?
    var purchaseTypes: [PurchaseTypesModel]?
    
    
    func getPriceModel() -> PriceModel? {
        if let arr = price, arr.count > 0 {
            return arr.first
        }
        return nil
    }
    
    func getRating( numberOfDigits : Int = 1) -> String {
        if let ratingCount {
            let disValue = String(format: "%0.\(numberOfDigits)f",ratingCount)
            if disValue != "0.0" && disValue != "0.00"{
                
                return "\(disValue)"
            }
        }
        return "0.0"
    }
    
    struct PriceModel: Decodable {
        var message: String?
        var value: Double?
        var isOfferPrice: Bool
        
        func getFormattedPrice( numberOfDigits : Int = 2) -> String {
            
            if let value {
                let disValue = String(format: "%0.\(numberOfDigits)f",value)
                if disValue != "0.0" && disValue != "0.00"{
                    
                    return "\(disValue)"
                }
            }
            
            
            return "0.0"
        }
    }
    
    struct PurchaseTypesModel: Decodable {
        var purchaseType: String?
        var displayName: String?
        var unitPrice: Double?
        var minQtyLimit: Int?
        var maxQtyLimit: Int?
        var cartQty: Int?
    }
}
