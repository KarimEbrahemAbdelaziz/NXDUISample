//
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

/// The base protocol of NXDUI. Describes an instance that has a
/// body which NXDUI knows how to display. The body is of type
/// `Body` which should be regarded as a flag interface,
/// without paying attention to the methods the protocol defines.
///
/// The protocol is prefixed with `_` to indicate that it should be
/// only used internally. For external usage - use the `View`
/// protocol
protocol _View {
    var body: Body { get }
}

/// A protocol deifnig a Body NXDUI knows how to display. Ideally,
/// the method in this protocol should be kept restricted to `internal`
/// usage within the N26NXD module.
///
/// This protocol should be implemented by two kinds of structs/classes
/// - Atoms - The base building blocks of NXDUI
/// - Containers - Used for composing different atoms/containers into
/// more complex views.
protocol Body: ConvertibleToASection {
    /// This method creates a new instance of a `UIView` subclass associated with this body.
    /// It's recommended to create a new `UIView` subclass matching the implementation
    /// of `Body`:
    /// For exapmple - creating `BodyTextView: UIView` as a counterpart to `BodyText: Body`
    func createUIView() -> UIView

    /// Adapt the `view` to match the caller. Use `other` to minimize the changes performed.
    ///
    /// - Parameter view: an `UIView` instance associated with `other`. This instance
    /// is guaranteed to match the type returned by `other.createBackingView()`.
    ///
    /// - Parameter other: the other instance implementing `Body`. Use this parameter
    /// to check if an adaptation is possible (`other` has same type as `self`), and to minimize
    /// the UI chages needed to be made
    ///
    /// - Parameter animated: Flag indicating if the chagnes need to be animated or not.
    ///
    /// - Returns: true if the caller managed to adapt to the changes, false otherwise.
    /// If `other` is the same type as the caller, this method is expected to return true.
    ///
    func adapt(view: UIView, from other: Any, animated: Bool) -> Bool
}

/// Extension of the internal `_View` protocol allowing each
/// `View` to also act as a `Body` by calling through
/// to it's own `body` property.
extension _View where Self: Body {
    func createUIView() -> UIView {
        return body.createUIView()
    }
    func adapt(view: UIView, from other: Any, animated: Bool) -> Bool {
        let bodyToCompareTo: Any
        if let otherView = other as? View {
            bodyToCompareTo = otherView.body
        } else {
            bodyToCompareTo = other
        }
        return body.adapt(view: view, from: bodyToCompareTo, animated: animated)
    }
}

/// Protocol for usage. Using the extension above, it allows
/// each type to implement `Body` simply by implementing
/// the `body` property
protocol View: _View, Body {}

/// Convenience to reduce boilerplate and add a bit of type safety
protocol TypeSafeBody: Body {
    associatedtype BackingView: UIView
    func createBackingView() -> BackingView
    func adapt(view: BackingView, from other: Self, animated: Bool)
}

extension TypeSafeBody {
    func createUIView() -> UIView {
        return createBackingView()
    }

    func adapt(view: UIView, from other: Any, animated: Bool) -> Bool {
        guard other is Self else { return false }
        assert(view is BackingView)
        adapt(view: view as! BackingView, from: other as! Self, animated: animated)
        return true
    }
}
