//
//  TitleLabel.swift
//  NXDUISample
//
//  Created by Ivan Damjanovic on 08.11.19.
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

struct Title: TypeSafeBody {
    let title: String
    init(_ title: String) {
        self.title = title
    }
    
    func createBackingView() -> TitleView {
        let view = TitleView()
        view.text = title
        return view
    }
    
    func adapt(view: TitleView, from other: Title, animated: Bool) {
        view.text = title
    }
}

class TitleView: UIView {
    private let label: UILabel
    init() {
        self.label = UILabel()
        super.init(frame: .zero)
        setupLabel()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var text: String {
        get {
            return label.text ?? ""
        }
        set {
            label.text = newValue
        }
    }
    
    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 1
        label.text = nil
    }
    
    private func setupLayout() {
        addSubview(label)
        
        label.addConstraints {[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]}
    }
    
}
