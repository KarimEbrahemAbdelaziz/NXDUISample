//
//  Unique.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 19.07.19.
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
