//
//  Copyright © 2019 N26. All rights reserved.
//

import Foundation

internal struct Unique: ID {
    private let randomHash = Int.random(in: 0..<Int.max)
    func isEqual(to other: ID) -> Bool {
        return false
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(randomHash)
    }
}
