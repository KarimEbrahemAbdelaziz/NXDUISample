//
//  DemoView.swift
//  NXDUISample
//
//  Created by Ivan Damjanovic on 08.11.19.
//  Copyright © 2019 N26. All rights reserved.
//

import Foundation

struct DemoViewModel {
    let title: String
}

struct DemoView: View {
    let viewModel: DemoViewModel
    
    var body: Body {
        return List {[
            Title(viewModel.title)
        ]}
    }
}
