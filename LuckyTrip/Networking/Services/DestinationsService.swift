//
//  DestinationsService.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import Foundation
enum DestinationsService: ServiceProtocol {

    case getListOfDestinations
    case searchForDestinations(searchValue: String)

    var baseURL: URL {
        return URL(string: "https://devapi.luckytrip.co.uk/api/")!
    }

    var version: String {
        return "2.0/"
    }

    var path: String {
        switch self {
        case .getListOfDestinations:
            return "test/destinations"
        case .searchForDestinations:
            return "test/destinations"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .searchForDestinations, .getListOfDestinations:
            return .get
        }
    }

    var task: Task {
        switch self {

        case .getListOfDestinations:
            return .requestPlain
        case .searchForDestinations(let searchValue):
            let parameters = [
                "search_value": searchValue,
                "search_type": "city_or_country"] as [String: Any]
            return .requestParameters(parameters)

        }
    }
    var headers: Headers? {
        return nil
    }
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .searchForDestinations, .getListOfDestinations :
            return .url
        default :
            return .json
        }
    }
}
