//
//  Reusable.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//


import Foundation
import UIKit

public protocol Reusable {

    static var reuseIdentifier: String { get }
    var reuseIdentifier: String { get }
}

public extension Reusable {

    static var reuseIdentifier: String {

        return String(describing: self)
    }

    var reuseIdentifier: String {

        return type(of: self).reuseIdentifier
    }
}
