//
//  ListingModel.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import Foundation


struct Product: Codable, Hashable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

struct Rating: Codable, Hashable {
    let rate: Double?
    let count: Int?
}
