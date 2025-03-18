//
//  ProductDetailService.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 18.03.2025.
//

import Foundation

protocol ProductDetailServiceProtocol {
    func fetchProductDetail(productID: Int) async throws -> Product
}

class ProductDetailService: ProductDetailServiceProtocol {
    func fetchProductDetail(productID: Int) async throws -> Product {
        return try await NetworkManager.shared.request(
            from: .productDetail(id: productID),
            method: .GET,
            body: nil,
            as: Product.self
        )
    }
}
