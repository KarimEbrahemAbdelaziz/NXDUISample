//
//  Copyright © 2019 N26. All rights reserved.
//

import Foundation

struct DemoViewModel {
    struct FoodViewModel: Identifiable {
        let title: String
        let id: ID
    }
    let title: String
    let filterLabel: String
    let filtering: Bool
    let onFilteringChanged: (Bool) -> Void
    let foods: [FoodViewModel]
}

struct DemoView: View {
    let viewModel: DemoViewModel
    
    var body: Body {
        return List {[
            VStack(
                alignment: .fill,
                content: {[
                    Title(viewModel.title),
                    Title(viewModel.filterLabel),
                    Toggle(
                        isOn: viewModel.filtering,
                        onSelectionChanged: viewModel.onFilteringChanged
                    )
                ]}
            ),
            Section(
                viewModels: viewModel.foods,
                body: FoodRow.init
            )
        ]}
    }
    
    struct FoodRow: View {
        let viewModel: DemoViewModel.FoodViewModel
        
        var body: Body {
            return Title(viewModel.title)
        }
    }
}
