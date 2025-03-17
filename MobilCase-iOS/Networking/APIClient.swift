//
//  APIClient.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(from endpoint: Endpoint,
                               method: HTTPMethod,
                               body: Data?,
                               as type: T.Type) async throws -> T
}
