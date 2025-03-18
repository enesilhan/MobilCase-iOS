//
//  ProductDetailViewModel.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 18.03.2025.
//

import Foundation

@MainActor
class ProductDetailViewModel {
    private let productService: ProductDetailServiceProtocol
    private let productID: Int

    var product: Product?
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?

    init(productID: Int, productService: ProductDetailServiceProtocol = ProductDetailService()) {
        self.productID = productID
        self.productService = productService
    }

    func fetchProductDetail() {
        Task {
            do {
                self.product = try await productService.fetchProductDetail(productID: productID)
                onDataUpdated?()
            } catch let error as NetworkError {
                onError?(error.localizedDescription)
            } catch {
                onError?("An unexpected error occurred.")
            }
        }
    }
}
