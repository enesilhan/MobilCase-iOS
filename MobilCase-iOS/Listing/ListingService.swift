//
//  ListingService.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 18.03.2025.
//

protocol ProductServiceProtocol {
    func fetchAllProducts() async throws -> [Product]
    func fetchLimitedProducts(limit: Int) async throws -> [Product]
}

class ProductService: ProductServiceProtocol {
    func fetchAllProducts() async throws -> [Product] {
        return try await NetworkManager.shared.request(
            from: .productListAll,
            method: .GET,
            body: nil,
            as: [Product].self
        )
    }

    func fetchLimitedProducts(limit: Int) async throws -> [Product] {
        return try await NetworkManager.shared.request(
            from: .productListLimited(limit: limit),
            method: .GET,
            body: nil,
            as: [Product].self
        )
    }
}
