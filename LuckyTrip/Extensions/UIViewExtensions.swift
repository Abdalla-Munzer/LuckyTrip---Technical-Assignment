//
//  UIViewExtensions.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 07/08/2022.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            // the masksToBound property if a shadow is needed in addition to the cornerRadius
            if self.layer.shadowOpacity > 0.0 {
                self.layer.masksToBounds = true
            }
        }
    }
}
