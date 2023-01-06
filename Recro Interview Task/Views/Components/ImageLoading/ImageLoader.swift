//
//  ImageLoader.swift
//  Recro Interview Task
//
//  Created by Brijesh on 05/01/23.
//

import Combine
import UIKit
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var isLoading = false
    
    private let url: URL
    private let emptyImageName: String?
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    
    init(url: String, emptyImageName: String) {
        self.url = URL(string: url)!
        self.emptyImageName = emptyImageName
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceNil(with: UIImage(named: emptyImageName ?? ""))
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
        
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
}
