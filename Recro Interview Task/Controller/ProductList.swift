//
//  ProductList.swift
//  Recro Interview Task
//
//  Created by Brijesh on 29/12/22.
//

import SwiftUI

struct ProductList: View {
    //MARK: - Variable Declaration
    @StateObject private var viewModel: ProductViewModel = ProductViewModel()
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    headerView
                    if(viewModel.state == .fetchingData || viewModel.state == .none) {
                        LoadingView()
                    }
                    else if (viewModel.state == .bindData) {
                        productListView
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
        .navigationViewStyle(StackNavigationViewStyle())
        
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
    
    //MARK: Header View
    private var headerView: some View {
        return AnyView(
            ZStack {
                HStack {
                    Spacer()
                }
                VStack {
                    Text(StringConstant.ScreenTitle.productList)
                        .font(.system(size: 22, weight: .medium))
                }
                HStack {
                    Spacer()
                    Button {
                        //
                        viewModel.FavouritePresented = true
                    } label: {
                        Image(systemName: ImageConstants.heartSelected)
                    }
                    NavigationLink(destination: FavouriteProductList(viewModel: viewModel), isActive: $viewModel.FavouritePresented) { EmptyView() }
//                        .isDetailLink(false)
                        .frame(width: 0, height: 0)
                        .hidden()
                }
            }.padding()
        )
    }
    
    //MARK: Word List View
    private var productListView: some View {
        return ScrollView(showsIndicators: false) {
            
            ForEach((0...((viewModel.productData.count) - 1)), id: \.self) { index in
                let productData = viewModel.productData[index]
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
                            viewModel.detailPresented = true
                        }
                }
            }
            NavigationLink(destination: ProductDetail(viewModel: viewModel, index: viewModel.index), isActive: $viewModel.detailPresented) { EmptyView() }
                .frame(width: 0, height: 0)
                .hidden()
            
        }
        .padding(.leading)
        .padding(.trailing)
        
    }
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList()
    }
}

