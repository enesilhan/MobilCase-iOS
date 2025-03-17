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
    var onDataUpdated: (() -> Void)?

    func fetchProducts() {
        Task {
            do {
                self.allProducts = try await NetworkManager.shared.request(
                    from: .productList,
                    method: .GET,
                    body: nil,
                    as: [Product].self
                )
                onDataUpdated?()
            } catch {
            }
        }
    }

    func getHorizontalProducts() -> [ProductSectionItem] {
        
        let horizontalItems = Array(allProducts.prefix(5)).map { ProductSectionItem.horizontal($0) }
        return horizontalItems
        
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
