//
//  RowStyle.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 20.07.19.
//

import Foundation

/// Built in NXD styles of sections. Providing any style other than .none
/// will result in all the rows in the section being wrapped in an appropriate
/// container.
enum SectionStyle {
    enum Color {
        case petrol
        case rhubarb
        case teal
        case wheat
    }
    case none // No container
    case outlined // Rows wrapped in outlined containers
    case elevated // Rows wrapped in elevated containers
    case colored(Color) // Rows wrapped in an appropriate colored container
}
