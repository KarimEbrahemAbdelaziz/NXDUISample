//
//  ViewWrapperDelegate.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 18.07.19.
//

import Foundation

//sourcery: AutoMockable
internal protocol ViewModelWrapperDelegate: AnyObject {
    func update(to view: View)
}
