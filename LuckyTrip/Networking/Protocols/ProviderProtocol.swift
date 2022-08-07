//
//  ProviderProtocol.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import Foundation
protocol ProviderProtocol {
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable
}
