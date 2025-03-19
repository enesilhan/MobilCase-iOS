//
//  ListingViewModel.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import Foundation

@MainActor
class ListingViewModel {
    private var allProducts: [Product] = []
    private var horizontalProducts: [Product] = []
    private let productService: ListingServiceProtocol

    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?

    init(productService: ListingServiceProtocol = ListingService()) {
        self.productService = productService
    }

    func fetchProducts() {
        Task {
            do {
                async let allProductsResponse = productService.fetchAllProducts()
                async let horizontalProductsResponse = productService.fetchLimitedProducts(limit: 5)

                self.allProducts = try await allProductsResponse
                self.horizontalProducts = try await horizontalProductsResponse
                onDataUpdated?()
            } catch {
                handleError(error)
            }
        }
    }

    private func handleError(_ error: Error) {
        if let networkError = error as? NetworkError {
            onError?(networkError.localizedDescription)
        } else {
            onError?("An unexpected error occurred.")
        }
    }

    func getHorizontalProducts() -> [ProductSectionItem] {
        return horizontalProducts.map { ProductSectionItem.horizontal($0) }
    }

    func getVerticalProducts() -> [ProductSectionItem] {
        return allProducts.map { .vertical($0) }
    }
}

enum ProductSectionItem: Hashable {
    case horizontal(Product)
    case vertical(Product)

    var product: Product {
        switch self {
        case .horizontal(let product), .vertical(let product):
            return product
        }
    }
}
