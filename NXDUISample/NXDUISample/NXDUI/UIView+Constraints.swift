//
//  UIView+Constraints.swift
//  NXDUISample
//
//  Created by Ivan Damjanovic on 08.11.19.
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraints(_ constraintsMaker: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        constraintsMaker(self).forEach { $0.isActive = true }
    }
}
