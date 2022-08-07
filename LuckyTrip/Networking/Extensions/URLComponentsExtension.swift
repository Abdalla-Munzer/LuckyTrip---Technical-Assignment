//
//  URLComponentsExtension.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//
import Foundation
extension URLComponents {

    init(service: ServiceProtocol) {
        let url = service.baseURL.appendingPathComponent(service.version).appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .url else { return }
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
