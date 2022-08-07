//
//  DestinationModel.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import Foundation

// MARK: - DestinationModel
struct DestinationModel: Codable {
    var destinations: [Destination]
}

// MARK: - Destination
struct Destination: Codable {
    let id: Int?
    let city, countryName, airportName, countryCode: String?
    let latitude, longitude: Double?
    let iataCode: String?
    let iataParentID: Int?
    let isEnabled: String?
    let temperature, originalDestinationID: Int?
    let thumbnail: Thumbnail?
    let destinationDescription: Description?
    let destinationImages: [String]?
    let destinationVideo: DestinationVideo?

    enum CodingKeys: String, CodingKey {
        case id, city
        case countryName = "country_name"
        case airportName = "airport_name"
        case countryCode = "country_code"
        case latitude, longitude
        case iataCode = "iata_code"
        case iataParentID = "iata_parent_id"
        case isEnabled = "is_enabled"
        case temperature
        case originalDestinationID = "original_destination_id"
        case thumbnail
        case destinationDescription = "description"
        case destinationImages = "destination_images"
        case destinationVideo = "destination_video"
    }
}

// MARK: - Description
struct Description: Codable {
    let id, objectID: Int?
    let objectType: String?
    let descriptionType: String?
    let text: String?
    let languageCode: String?
    let translated: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case objectID = "object_id"
        case objectType = "object_type"
        case descriptionType = "description_type"
        case text
        case languageCode = "language_code"
        case translated
    }
}

// MARK: - DestinationVideo
struct DestinationVideo: Codable {
    let url: String?
    let thumbnail: Thumbnail?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let imageType: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageType = "image_type"
        case imageURL = "image_url"
    }
}
