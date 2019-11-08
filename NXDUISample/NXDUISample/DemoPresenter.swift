//
//  DemoPresenter.swift
//  NXDUISample
//
//  Created by Ivan Damjanovic on 08.11.19.
//  Copyright © 2019 N26. All rights reserved.
//

import Foundation

class DemoPresenter: LifecycleObserver {
    private let view: ViewModelWrapper<DemoViewModel>
    init (view: ViewModelWrapper<DemoViewModel>) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.viewModel = DemoViewModel(title: "Demo!")
    }
}
