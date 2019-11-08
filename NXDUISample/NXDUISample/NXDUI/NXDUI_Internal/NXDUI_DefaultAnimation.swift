//
//  NXDUI_DefaultAnimation.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 23.07.19.
//

import UIKit

internal enum NXDUIAnimation {
    static let defaultDuration: TimeInterval = 0.3
}

internal extension UIView {
    func updateLayout(animated: Bool, _ updateConstraints: @escaping () -> Void) {
        if animated {
            UIView.animate(withDuration: NXDUIAnimation.defaultDuration, animations: {
                updateConstraints()
                self.layoutIfNeeded()
            })
        } else {
            updateConstraints()
            layoutIfNeeded()
        }
    }

    func perform(animated: Bool, perform: @escaping () -> Void) {
        if animated {
            UIView.animate(withDuration: NXDUIAnimation.defaultDuration, animations: {
                perform()
            })
        } else {
            perform()
        }
    }
}
