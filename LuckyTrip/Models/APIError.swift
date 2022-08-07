//
//  APIError.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import Foundation

// MARK: - SearchError
struct APIError: Codable {
    let error: String
    let errorDetails: ErrorDetails

    enum CodingKeys: String, CodingKey {
        case error
        case errorDetails = "error_details"
    }
}

// MARK: - ErrorDetails
struct ErrorDetails: Codable {
    let searchType: [String]

    enum CodingKeys: String, CodingKey {
        case searchType = "search_type"
    }
}
