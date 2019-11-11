//
//  Copyright © 2019 N26. All rights reserved.
//

import Foundation

struct Food {
    let name: String
    let isHealthy: Bool
}

struct DemoPresenter: LifecycleObserver {
    private let view: ViewModelWrapper<DemoViewModel>
    private let allFoods: [Food]
    init (view: ViewModelWrapper<DemoViewModel>) {
        self.view = view
        self.allFoods = [
            Food(name: "Apple", isHealthy: true),
            Food(name: "Chocholate", isHealthy: false),
            Food(name: "Currywurst", isHealthy: false),
            Food(name: "Pepi", isHealthy: true),
            Food(name: "Salad", isHealthy: true),
            Food(name: "Cereal", isHealthy: false)
        ]
    }
    
    func viewDidLoad() {
        view.viewModel = viewModel(for: false)
    }
    
    private func viewModel(for filtering: Bool) -> DemoViewModel {
        let foods = allFoods.filter { $0.isHealthy || !filtering }
        return DemoViewModel(
            title: "Foods",
            filterLabel: "Healthy only:",
            filtering: filtering,
            onFilteringChanged: onFilteringChanged(_:),
            foods: foods.map { DemoViewModel.FoodViewModel(title: $0.name, id: $0.name) }
        )
    }
    
    private func onFilteringChanged(_ value: Bool) {
        view.viewModel = viewModel(for: value)
    }
}
