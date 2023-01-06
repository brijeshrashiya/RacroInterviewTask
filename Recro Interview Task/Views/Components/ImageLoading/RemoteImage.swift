//
//  RemoteImage.swift
//  Recro Interview Task
//
//  Created by Brijesh on 05/01/23.
//

import SwiftUI
import UIKit

struct RemoteImage<Placeholder: View>: View {
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    private let url: String
    private let emptyImage: String
    
    init(
        url: String,
        emptyImage: String = ImageConstants.noDataPlaceHoleder,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.url = url
        self.emptyImage = emptyImage
        self.placeholder = placeholder()
        self.image = image
    }
    
    var body: some View {
        if(url.count > 0) {
            LoadImageFromURL(
                url: url, emptyImage: emptyImage,
                placeholder: { placeholder },
                image: image
            )
        }
        else {
            image(UIImage(named: emptyImage)!)
        }
    }
    
}

fileprivate struct LoadImageFromURL<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: String,
        emptyImage: String,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, emptyImageName: emptyImage))
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


