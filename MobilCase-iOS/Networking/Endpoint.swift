//
//  Endpoint.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import Foundation

enum Endpoint {
    case productListAll
    case productListLimited(limit: Int)
    case productDetail(id: Int)

    private static let baseURL = "https://fakestoreapi.com/products"

    var url: URL? {
        switch self {
        case .productListAll:
            return URL(string: Endpoint.baseURL)
        case .productListLimited(let limit):
            return URL(string: "\(Endpoint.baseURL)?limit=\(limit)")
        case .productDetail(let id):
            return URL(string: "\(Endpoint.baseURL)/\(id)")
        }
    }
}
