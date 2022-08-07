//
//  NetworkResponse.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import Foundation
enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
    case apiFailure(APIError)
}
