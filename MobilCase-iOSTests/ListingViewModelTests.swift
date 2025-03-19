//
//  ListingViewModelTests.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 19.03.2025.
//

import XCTest
@testable import MobilCase_iOS

@MainActor
final class ListingViewModelTests: XCTestCase {

    var viewModel: ListingViewModel!
    var mockService: MockListingService!

    override func setUp() async throws {
        try await super.setUp()
        mockService = MockListingService()
        viewModel = ListingViewModel(productService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testGetHorizontalProductsCount() async {
        let expectation = XCTestExpectation(description: "Wait for products to be fetched")

        viewModel.onDataUpdated = {
            expectation.fulfill()
        }

        await viewModel.fetchProducts()
        await fulfillment(of: [expectation], timeout: 1.0)

        let horizontalProducts = viewModel.getHorizontalProducts()

        XCTAssertEqual(horizontalProducts.count, 5, "Horizontal products count should be 5")
    }
}
