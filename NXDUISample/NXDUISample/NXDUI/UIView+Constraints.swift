//
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraints(_ constraintsMaker: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        constraintsMaker(self).forEach { $0.isActive = true }
    }
}
