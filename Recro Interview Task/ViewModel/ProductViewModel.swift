//
//  ProductViewModel.swift
//  Recro Interview Task
//
//  Created by Brijesh on 29/12/22.
//

import SwiftUI
import Combine
import Foundation

class ProductViewModel: ObservableObject {
    
    // MARK: - Variable Declaration
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: MainViewState = .none {
        didSet {
            print("new state \(state)")
        }
    }
    @Published private(set) var favouriteState: FavouriteViewState = .none {
        didSet {
            print("new state \(state)")
        }
    }
    
    @Published var productData : [ProductModel] = []
    @Published var favouriteProductData : [ProductModel] = []
    @Published var detailPresented : Bool = false
    @Published var detailPresentedFromFavourite : Bool = false
    @Published var FavouritePresented : Bool = false
    @AppStorage("favourite") var favouriteData : [String] = []
    @Published var index : Int = 0
    
    // MARK: - Init
    init() {
        publishState(.none)
        publishFilterState(.none)
        callAPIForGetProductList()
    }

    // MARK: Publish State
    private func publishState(_ updateState : MainViewState){
        self.state = updateState
    }
    
    private func publishFilterState(_ updateState : FavouriteViewState){
        self.favouriteState = updateState
    }
    
    func setFavouriteUnFavourite(model:ProductModel) {
        productData = productData.map({ obj in
            var product = obj
            if(product.id == model.id) {
                if((product.isFavourite ?? false)) {
                    //
                    favouriteData.removeAll { strId in
                        return product.id == strId
                    }
                    product.isFavourite = false
                    self.favouriteProductData.removeAll { favProduct in
                        return favProduct.id == product.id
                    }
                }
                else {
                    //
                    favouriteData.append(product.id ?? "")
                    product.isFavourite = true
                    self.favouriteProductData.append(product)
                }
            }
            return product
        })
        
        if(favouriteProductData.count > 0){
            publishFilterState(.bindData)
        }
        else{
            publishFilterState(.emptyData)
        }
    }
    
   
    
}
// MARK: - API Calling
extension ProductViewModel {
    
    private func callAPIForGetProductList() {
        publishState(.none)
        publishFilterState(.none)
        productData = []
        publishState(.fetchingData)
        publishFilterState(.fetchingData)
        

        Task {
            do {
                
                let obj = try await APIManager().getProductList()
                DispatchQueue.main.async {
                    if let arr = obj.products, arr.count > 0 {
                        // update with favourite
                        self.productData = arr.map({ model in
                            var product = model
                            if (self.favouriteData.contains(product.id ?? "")) {
                                product.isFavourite = true
                            }
                            return product
                        })
                        
                        self.favouriteProductData = self.productData.filter({ model in
                            return (model.isFavourite ?? false)
                        })
                        self.publishState(.bindData)
                        if(self.favouriteProductData.count > 0){
                            self.publishFilterState(.bindData)
                        }
                        else{
                            self.publishFilterState(.emptyData)
                        }
                    }
                    else {
                        self.publishState(.emptyData)
                        self.publishFilterState(.emptyData)
                    }
                  }
                
            } catch {
                DispatchQueue.main.async {
                    self.publishState(.emptyData)
                    self.publishFilterState(.emptyData)
                  }
                print("Error getting result: \(error)")
            }
        }
    }
}

// MARK: - Main View State
enum MainViewState: Equatable {
    case none
    case bindData
    case fetchingData
    case emptyData
    

    static func == (lhs: MainViewState, rhs: MainViewState) -> Bool {
        switch (lhs, rhs) {
            case (.none, .none):
                return true
            case (.bindData, .bindData):
                return true
            case (.fetchingData, .fetchingData):
                return true
            case (.emptyData, .emptyData):
                return true
            default:
                return false
        }
    }
}

// MARK: - Favourite View State
enum FavouriteViewState: Equatable {
    case none
    case bindData
    case fetchingData
    case emptyData
    

    static func == (lhs: FavouriteViewState, rhs: FavouriteViewState) -> Bool {
        switch (lhs, rhs) {
            case (.none, .none):
                return true
            case (.bindData, .bindData):
                return true
            case (.fetchingData, .fetchingData):
                return true
            case (.emptyData, .emptyData):
                return true
            default:
                return false
        }
    }
}
