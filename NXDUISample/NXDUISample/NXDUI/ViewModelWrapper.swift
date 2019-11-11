//
//  Copyright © 2019 N26. All rights reserved.
//

import Foundation

/// Replacement for SwiftUI's @State property.
/// Use this class as an interface towards the View layer in your
/// presentation/business logic components.
class ViewModelWrapper<ViewModel> {
    /// Syntax sugar for setting the `viewModel`. Setting the `viewModel` will
    /// cause the `View` to be updated.
    var viewModel: ViewModel {
        set {
            _viewModel = newValue
        }
        get {
            fatalError("Getting the `viewModel` isn't supported. It's declared as a property to make the set syntax nicer")
        }
    }
    private var _viewModel: ViewModel? {
        didSet {
            let view = viewClosure(_viewModel!)
            delegate?.update(to: view)
        }
    }

    private let viewClosure: (ViewModel) -> View
    init(viewClosure: @escaping (ViewModel) -> View) {
        self.viewClosure = viewClosure
    }

    internal weak var delegate: ViewModelWrapperDelegate?
}
