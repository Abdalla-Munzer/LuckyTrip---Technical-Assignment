//
//  AppRouter.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import Foundation

typealias RoutableController = BaseViewController & StoryboardBased

class AppRouter {

    // To add new routing destination, conform to its related Router
    static func route(
        to routable: RoutableController.Type,
        from context: BaseViewController, modal: Bool = false) {

        let controller = routable.instantiate()

        if modal {
            context.present(controller, animated: true)
        } else {
            context.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

/// Base presentation protocol
public protocol LTRouter {

    static func push(_ controller: BaseViewController, from context: BaseViewController, animated: Bool)
    static func present(_ controller: BaseViewController, from context: BaseViewController, animated: Bool, completion: (() -> Void)?)
}

extension LTRouter {

    static func push(_ controller: BaseViewController, from context: BaseViewController, animated: Bool = true) {

        context.navigationController?.pushViewController(controller, animated: animated)
    }

    static func present(_ controller: BaseViewController, from context: BaseViewController, animated: Bool = true, completion: (() -> Void)? = nil) {

        context.present(controller, animated: animated, completion: completion)
    }
}
