//
//  UIViewControllerExtenstions.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import UIKit

extension UIViewController {
    func showAlertWith(title: String?, titleAttributes: [NSAttributedString.Key: Any]? = nil,
                       message: String, messageAttributes: [NSAttributedString.Key: Any]? = nil,
                       actions: [UIAlertAction], method: String? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let title = title, let attributes = titleAttributes {
            let attributeString = NSMutableAttributedString(string: title)
            attributeString.addAttributes(attributes, range: NSRange(location: 0, length: title.utf8.count))
            alert.setValue(attributeString, forKey: "attributedTitle")
        }
        if let attributes = messageAttributes {
            let attributeString = NSMutableAttributedString(string: message)
            attributeString.addAttributes(attributes, range: NSRange(location: 0, length: message.utf8.count))
            alert.setValue(attributeString, forKey: "attributedMessage")
        }

        for action in actions {
            alert.addAction(action)
        }
        alert.preferredAction = actions.count > 1 ? actions[1] : nil
        UIApplication.shared.keyWindow?
            .rootViewController?
            .topMostViewController()
            .present(alert, animated: true, completion: nil)
    }
    func topMostViewController() -> UIViewController {
        guard let presentedVC = self.presentedViewController else {
            return self
        }
        if let navigation = presentedVC as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? self
        }
        if let tab = presentedVC as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return presentedVC.topMostViewController()
    }
}

extension UIViewController {
    func containedInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
