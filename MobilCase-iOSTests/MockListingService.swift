//
//  MockListingService.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 19.03.2025.
//

import XCTest
@testable import MobilCase_iOS

class MockListingService: ListingServiceProtocol {
    var shouldReturnError = false
    
    func fetchAllProducts() async throws -> [Product] {
        if shouldReturnError {
            throw NSError(domain: "", code: -1)
        }
        return Array(repeating: createMockProduct(), count: 10)
    }
    
    func fetchLimitedProducts(limit: Int) async throws -> [Product] {
        if shouldReturnError {
            throw NSError(domain: "", code: -1)
        }
        return Array(repeating: createMockProduct(), count: limit)
    }
    
    private func createMockProduct() -> Product {
        return Product(
            id: 1,
            title: "Test Product",
            price: 99.9,
            description: "Test Description",
            category: "Test Category",
            image: "test_image_url",
            rating: Rating(rate: 4.5, count: 100)
        )
    }
}
