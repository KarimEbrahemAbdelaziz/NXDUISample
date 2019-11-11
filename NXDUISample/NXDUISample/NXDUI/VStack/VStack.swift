//
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

struct VStack: TypeSafeBody {
    enum SupportedAlignment {
        case center
        case fill

        var alignment: UIStackView.Alignment {
            switch self {
            case .center:
                return .center
            case .fill:
                return .fill
            }
        }
    }
    private let content: [Body]
    private let alignment: SupportedAlignment
    init(alignment: SupportedAlignment = .fill, content: () -> [Body]) {
        self.content = content()
        self.alignment = alignment
    }

    func createBackingView() -> VStackView {
        return VStackView(content.map { $0.createUIView() }, alignment: alignment)
    }

    func adapt(view: VStackView, from other: VStack, animated: Bool) {
        assert(other.content.count == view.arrangedSubviews.count)
        let bodyViewPairs = Array(zip(other.content, view.arrangedSubviews))

        let minCount = min(content.count, bodyViewPairs.count)
        for index in 0..<minCount {
            let newBody = content[index]
            let pair = bodyViewPairs[index]

            if !newBody.adapt(view: pair.1, from: pair.0, animated: animated) {
                view.removeArrangedSubview(pair.1)
                pair.1.removeFromSuperview()
                view.insertArrangedSubview(newBody.createUIView(), at: index)
            }
        }

        if minCount < content.count {
            for index in minCount..<content.count {
                view.addArrangedSubview(content[index].createUIView())
            }
        } else if minCount < bodyViewPairs.count {
            for index in minCount..<bodyViewPairs.count {
                view.removeArrangedSubview(bodyViewPairs[index].1)
                bodyViewPairs[index].1.removeFromSuperview()
            }
        }
    }
}

final class VStackView: UIStackView {
    

    init(_ content: [UIView], alignment: VStack.SupportedAlignment = .fill) {
        super.init(frame: .zero)

        content.forEach { addArrangedSubview($0) }

        self.axis = .vertical
        self.alignment = alignment.alignment
        self.distribution = .fill
        self.spacing = 0
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
