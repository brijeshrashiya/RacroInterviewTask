//
//  FavouriteProductList.swift
//  Recro Interview Task
//
//  Created by Brijesh on 30/12/22.
//

import SwiftUI

struct FavouriteProductList: View {
    //MARK: - Variable Declaration
    @StateObject var viewModel: ProductViewModel = ProductViewModel(service: APIManager())
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    dismissButtonView
                    if(viewModel.favouriteState == .fetchingData || viewModel.favouriteState == .none) {
                        LoadingView()
                    }
                    else if (viewModel.favouriteState == .bindData) {
                        productListView
                    }
                    else if (viewModel.favouriteState == .emptyData){
                        emptyView
                    }
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .background(Color.clear)
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
    
    //MARK: - Dismiss Button View
    private var dismissButtonView: some View {
        return AnyView(
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: ImageConstants.back)
                        .foregroundColor(ColorConstant.AccentColor)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                })

                Spacer()
                Text(StringConstant.ScreenTitle.favouriteProductList)
                    .font(.system(size: 22, weight: .medium))
                Spacer()
            }.padding([.top, .leading])
        )
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
    
    //MARK: Word List View
    private var productListView: some View {
        return ScrollView(showsIndicators: false) {
            
            ForEach((0...((viewModel.favouriteData.count) - 1)), id: \.self) { index in
                let productData = viewModel.favouriteProductData[index]
                ZStack {
                    
                        HStack() {
                                AsyncImage(url: URL(string: productData.imageURL ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text(productData.title ?? "-")
                                    .fontWeight(.medium)
                                    .padding(.bottom, 4)
                                    
                                Text("Price: \(productData.getPriceModel()?.getFormattedPrice() ?? "")")
                                        .fontWeight(.light)
                                        .padding(.bottom, 4)
                                HStack() {
                                    Button {
                                       viewModel.setFavouriteUnFavourite(model: productData)
                                    } label: {
                                        Image(systemName: (productData.isFavourite ?? false) ? ImageConstants.heartSelected : ImageConstants.heart)
                                    }
                                    .padding(.trailing, 10)
                                    
                                    Button {
                                        //
                                    } label: {
                                        Image(systemName: ImageConstants.cart)
                                    }
                                    Spacer()
                                }
                                .padding(.bottom, 4)
                                .padding(.top, 4)
                            }
                            Spacer()
                        }
                        .frame(
                              maxWidth: .infinity
                            )
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .onTapGesture {
                            viewModel.index = index
                            viewModel.detailPresentedFromFavourite = true
                        }
                }
            }
            NavigationLink(destination: ProductDetail(viewModel: viewModel, index: viewModel.index, isFromFavourite: true), isActive: $viewModel.detailPresentedFromFavourite) { EmptyView() }
                .isDetailLink(false)
                .frame(width: 0, height: 0)
                .hidden()
            
        }
        .padding(.leading)
        .padding(.trailing)
        
    }
}


struct FavouriteProductList_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteProductList()
    }
}
