//
//  NetworkManager.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import Foundation

final class NetworkManager: APIClient {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(from endpoint: Endpoint,
                               method: HTTPMethod = .GET,
                               body: Data? = nil,
                               as type: T.Type) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.badRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return try JSONDecoder().decode(T.self, from: data)
            case 400:
                throw NetworkError.badRequest
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 500...599:
                throw NetworkError.serverError
            default:
                throw NetworkError.unknown
            }
        } catch {
            throw NetworkError.decodingError
        }
    }
}
