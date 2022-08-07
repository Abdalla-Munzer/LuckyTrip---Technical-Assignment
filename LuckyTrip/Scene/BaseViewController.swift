//
//  BaseViewController.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    lazy var loaderView: UIActivityIndicatorView = {
        var activityIndicatorView: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        }
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return activityIndicatorView
    }()

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    open override func viewDidLoad() {

        super.viewDidLoad()
        hideKeyboard()
    }

    open override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        if preferredStatusBarStyle == .lightContent {
            navigationController?.navigationBar.barStyle = .black
        } else {
            navigationController?.navigationBar.barStyle = .default
        }

    }
    func showError(message: String) {
        let action = UIAlertAction.init(title: "Done", style: .cancel, handler: nil)
        showAlertWith(title: "Error", message: message, actions: [action])
    }
    open func hideKeyboard() {
        hideKeyboardWhenTappedAround()
    }

    open override var prefersStatusBarHidden: Bool {
        return true
    }

    func hideKeyboardWhenTappedAround() {

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
}
