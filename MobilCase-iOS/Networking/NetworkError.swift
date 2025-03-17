//
//  NetworkError.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case decodingError
    case unknown

    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad request. Please try again."
        case .unauthorized:
            return "Unauthorized access. Please check your credentials."
        case .forbidden:
            return "Access to this resource is forbidden."
        case .notFound:
            return "Requested resource was not found."
        case .serverError:
            return "Server encountered an error. Please try again later."
        case .decodingError:
            return "Failed to decode the response."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
