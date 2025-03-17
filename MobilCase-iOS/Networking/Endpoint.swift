//
//  Endpoint.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import Foundation

enum Endpoint {
    case productList
    case productDetail(id: Int)

    private static let baseURL = "https://fakestoreapi.com/products"

    var url: URL? {
        switch self {
        case .productList:
            return URL(string: "\(Endpoint.baseURL)")
        case .productDetail(let id):
            return URL(string: "\(Endpoint.baseURL)/\(id)")
        }
    }
}
