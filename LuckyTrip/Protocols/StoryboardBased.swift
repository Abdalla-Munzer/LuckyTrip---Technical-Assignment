//
//  StoryboardBased.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//



import Foundation
import UIKit

/// Protocol to conform to be instantiated from storyboard
/// Warning: Storyboard identifier must be same as the reuse identifier!
public protocol StoryboardBased: Reusable {

    static var storyboardName: String { get }
}

public extension StoryboardBased {

    static func instantiate() -> Self {

        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: reuseIdentifier) as? Self else {
            fatalError(reuseIdentifier + " cannot be instantiated via storyboard")
        }

        return viewController
    }
}
