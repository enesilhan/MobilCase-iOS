//
//  ListingModel.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

struct ListingModel: Codable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: String?
    var image: String?
    var rating: Rating?
}

struct Rating: Codable {
    var rate: Double?
    var count: Int?
}
