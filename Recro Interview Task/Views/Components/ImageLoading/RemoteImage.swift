//
//  RemoteImage.swift
//  Recro Interview Task
//
//  Created by Brijesh on 05/01/23.
//

import SwiftUI

struct RemoteImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, emptyImageName: ImageConstants.noDataPlaceHoleder))
        
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            }
            else {
                placeholder
            }
        }
    }
}
