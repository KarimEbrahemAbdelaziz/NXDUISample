//
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

internal class ListViewTableViewCell: UITableViewCell {
    private let host = NXDUIHostView(content: nil)
    private func setupLayout() {
        guard contentView.subviews.isEmpty else { return }
        backgroundColor = .clear

        contentView.addSubview(host)

        host.addConstraints {[
            $0.topAnchor.constraint(equalTo: contentView.topAnchor),
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: $0.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: $0.trailingAnchor)
        ]}
    }

    private var currentBody: Body?
    func adapt(to: Body, animated: Bool) {
        setupLayout()
        host.adapt(to: to, from: currentBody, animated: animated)
        currentBody = to
    }
}
