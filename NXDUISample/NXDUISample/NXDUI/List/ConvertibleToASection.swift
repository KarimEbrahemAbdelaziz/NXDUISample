//
//  ConvertibleToASection.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 19.07.19.
//

import Foundation

/// Anything that can be converted to a section
protocol ConvertibleToASection {
    var asSection: Section { get }
}

/// Any body can be converted in a simple section with 1 row
extension Body {
    var asSection: Section {
        return Section([_Row(body: self)])
    }
}
