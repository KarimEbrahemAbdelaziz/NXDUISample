//
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

protocol LifecycleObserver {
    func viewDidLoad()
    func viewWillAppear()
}

extension LifecycleObserver {
    func viewWillAppear() {}
}

/// NXDUI counterpart of UIHostingController. Use this class to display and update an
/// instance of `View`
class NXDUIHostingController<ViewModel>: UIViewController, ViewModelWrapperDelegate {
    private let wrapper: ViewModelWrapper<ViewModel>
    private let host: NXDUIHostView
    private let lifecycleObserver: LifecycleObserver
    init(wrapper: ViewModelWrapper<ViewModel>, lifecycleObserver: LifecycleObserver) {
        self.wrapper = wrapper
        self.host = NXDUIHostView(content: nil)
        self.lifecycleObserver = lifecycleObserver
        super.init(nibName: nil, bundle: nil)
        wrapper.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        lifecycleObserver.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycleObserver.viewWillAppear()
    }

    private func setupLayout() {
        view.addSubview(host)
        
        host.addConstraints {[
            $0.topAnchor.constraint(equalTo: view.topAnchor),
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: $0.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: $0.trailingAnchor)
        ]}
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var currentBody: Body?
    internal func update(to view: View) {
        let body = view.body
        if let currentBody = currentBody {
            host.adapt(to: body, from: currentBody, animated: true)
            self.currentBody = body
        } else {
            currentBody = body
            host.host(body.createUIView(), animated: false)
        }
    }
}

