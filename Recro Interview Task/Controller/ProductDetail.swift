//
//  ProductDetail.swift
//  Recro Interview Task
//
//  Created by Brijesh on 30/12/22.
//

import SwiftUI

struct ProductDetail: View {
    
    //MARK: - Variable Declaration
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ProductViewModel
    var index: Int
    var isFromFavourite:Bool = false
    
    var body: some View {
            NavigationView {
                ZStack {
                    VStack {
                        if (viewModel.state == .bindData) {
                            productDetailView
                        }
                        else if (viewModel.state == .emptyData){
                            emptyView
                        }
                        Spacer()
                    }
                }
                .navigationBarHidden(true)
                .background(Color.clear)
            }
    }
    
    //MARK: EmptyView
    private var emptyView: some View {
        return VStack(spacing: 10) {
            Text(StringConstant.General.noDataFound)
                .font(.title2)
            Spacer()
        }
        .offset(x: 0, y: 40)
    }
    
    //MARK: Product Detail View
    private var productDetailView: some View {
        return ScrollView(showsIndicators: false) {
            
            let productData = viewModel.productData[index]
            
            VStack() {
                    AsyncImage(url: URL(string: productData.imageURL ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(
//                          maxWidth: .infinity,
                          minHeight: 200,
                          maxHeight: 200
                        )
                    .padding(.bottom, 4)
               
                Text(productData.title ?? "-")
                    .fontWeight(.medium)
                    .padding(.bottom, 4)
                    
                Text("Price: \(productData.getPriceModel()?.getFormattedPrice() ?? "")")
                        .fontWeight(.light)
                        .padding(.bottom, 4)
                HStack() {
                    if(isFromFavourite == false) {
                        Button {
                            viewModel.setFavouriteUnFavourite(model: productData)
                        } label: {
                            Image(systemName: (productData.isFavourite ?? false) ? ImageConstants.heartSelected : ImageConstants.heart)
                        }
                        .padding(.trailing, 10)
                    }
                    
                    Button {
                    } label: {
                        Image(systemName: ImageConstants.cart)
                    }
                    Text("Rating: \(productData.getRating())")
                            .fontWeight(.light)
                            .foregroundColor(.yellow)
                    Spacer()
                }
                .padding(.bottom, 4)
                .padding(.top, 4)
            }
            .frame(
                  maxWidth: .infinity
                )
            .padding()
            .cornerRadius(10)
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

//struct ProductDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetail(viewModel: <#ProductViewModel#>, index: <#Int#>)
//    }
//}
