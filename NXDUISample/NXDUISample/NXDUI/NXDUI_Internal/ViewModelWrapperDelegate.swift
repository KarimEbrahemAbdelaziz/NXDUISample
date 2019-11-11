//
//  Copyright © 2019 N26. All rights reserved.
//

import Foundation

internal protocol ViewModelWrapperDelegate: AnyObject {
    func update(to view: View)
}
