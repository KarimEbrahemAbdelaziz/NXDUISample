//
//  Identifiable.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 19.07.19.
//

import Foundation

/// Anything having an ID
protocol Identifiable {
    var id: ID { get }
}

/// Anything that can be compared to another ID and decide if
/// they are the same
protocol ID {
    func isEqual(to other: ID) -> Bool
    func hash(into hasher: inout Hasher)
}

extension ID where Self: Hashable {
    func isEqual(to other: ID) -> Bool {
        guard let other = other as? Self else { return false }
        return other == self
    }
}

/// String is an ID
extension String: ID {}
/// Int is an ID
extension Int: ID {}
