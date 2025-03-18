//
//  ListingService.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 18.03.2025.
//

protocol ListingServiceProtocol {
    func fetchAllProducts() async throws -> [Product]
    func fetchLimitedProducts(limit: Int) async throws -> [Product]
}

class ListingService: ListingServiceProtocol {
    func fetchAllProducts() async throws -> [Product] {
        return try await fetchProducts(endpoint: .productListAll)
    }

    func fetchLimitedProducts(limit: Int) async throws -> [Product] {
        return try await fetchProducts(endpoint: .productListLimited(limit: limit))
    }

    private func fetchProducts(endpoint: Endpoint) async throws -> [Product] {
        return try await NetworkManager.shared.request(
            from: endpoint,
            method: .GET,
            body: nil,
            as: [Product].self
        )
    }
}
