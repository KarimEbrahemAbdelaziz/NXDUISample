//
//  NXDUIContentReplacingView.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 18.07.19.
//

import UIKit

internal class NXDUIHostView: UIView {
    private(set) var content: UIView?

    internal init(content: UIView?) {
        self.content = content

        super.init(frame: .zero)

        if let content = content {
            host(content, animated: false)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func host(_ newContent: UIView?, animated: Bool) {
        if animated {
            let duration = NXDUIAnimation.defaultDuration / 2
            let currentContent = content

            if let newContent = newContent {
                insertSubview(newContent, at: 0)

                newContent.addConstraints {[
                    $0.topAnchor.constraint(equalTo: topAnchor),
                    $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                    bottomAnchor.constraint(equalTo: $0.bottomAnchor),
                    trailingAnchor.constraint(equalTo: $0.trailingAnchor)
                ]}

                content = newContent
                newContent.alpha = 0
            }

            layoutIfNeeded()

            UIView.animate(withDuration: duration, animations: {
                currentContent?.alpha = 0
            }, completion: { _ in
                currentContent?.removeFromSuperview()

                UIView.animate(withDuration: duration, animations: {
                    self.content?.alpha = 1
                })
            })
        } else {
            content?.removeFromSuperview()

            if let newContent = newContent {
                addSubview(newContent)

                newContent.addConstraints {[
                    $0.topAnchor.constraint(equalTo: topAnchor),
                    $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                    bottomAnchor.constraint(equalTo: $0.bottomAnchor),
                    trailingAnchor.constraint(equalTo: $0.trailingAnchor)
                ]}
            }

            content = newContent
        }
    }

    func adapt(to: Body?, from: Body?, animated: Bool) {
        guard let to = to else {
            host(nil, animated: animated)
            return
        }

        guard let content = content else {
            host(to.createUIView(), animated: animated)
            return
        }

        guard let from = from else {
            return
        }

        if to.adapt(view: content, from: from, animated: animated) == false {
            host(to.createUIView(), animated: animated)
        }
    }
}
