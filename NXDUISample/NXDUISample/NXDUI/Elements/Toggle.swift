//
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

struct Toggle: TypeSafeBody {
    let isOn: Bool
    let onSelectionChanged: (Bool) -> Void
    init(isOn: Bool, onSelectionChanged: @escaping (Bool) -> Void) {
        self.isOn = isOn
        self.onSelectionChanged = onSelectionChanged
    }
    
    func createBackingView() -> ToggleView {
        let view = ToggleView()
        view.setOn(isOn, animated: false)
        view.onSelectionChanged = onSelectionChanged
        return view
    }
    
    func adapt(view: ToggleView, from other: Toggle, animated: Bool) {
        view.setOn(isOn, animated: animated)
        view.onSelectionChanged = onSelectionChanged
    }
}

class ToggleView: UIView {
    private let toggle: UISwitch
    init() {
        self.toggle = UISwitch()
        super.init(frame: .zero)
        setupLayout()
        setupEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setOn(_ isOn: Bool, animated: Bool) {
        if toggle.isOn != isOn {
            toggle.setOn(isOn, animated: animated)
        }
    }
    
    var onSelectionChanged: ((Bool) -> Void)? = nil
    
    private func setupLayout() {
        addSubview(toggle)
        
        toggle.addConstraints {[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]}
    }
    
    private func setupEvents() {
        toggle.addTarget(self, action: #selector(didChangeToggleValue), for: .valueChanged)
    }
    
    @objc private func didChangeToggleValue() {
        onSelectionChanged?(toggle.isOn)
    }
    
}
