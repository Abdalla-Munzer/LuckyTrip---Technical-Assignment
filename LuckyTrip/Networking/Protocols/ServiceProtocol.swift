//
//  ServiceProtocol.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//
import Foundation

typealias Headers = [String: String]

protocol ServiceProtocol {
    var baseURL: URL { get }
    var version: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
