//
//  Copyright © 2019 N26. All rights reserved.
//

import Foundation

/// Internal structure containing everything List needs to display a single item
internal struct _Row {
    let body: Body
    let id: ID
    let action: () -> Void

    /// Initializer with all fields
    init(body: Body, id: ID, action: @escaping () -> Void) {
        self.body = body
        self.id = id
        self.action = action
    }

    /// Convenience for an Identifiable Body
    init(row: Row, action: @escaping () -> Void) {
        self.init(body: row, id: row.id, action: action)
    }

    /// Convenience for a non-identifiable Body
    init(body: Body) {
        self.init(body: body, id: Unique(), action: {})
    }
}
