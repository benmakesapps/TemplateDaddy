import SwiftUI

/// Manages the push/pop navigation path for a ``Stack``.
///
/// You don't create this yourself — ``Stack`` creates one and injects it
/// into the SwiftUI environment. Grab it from any child view to
/// push, pop, or return to the root.
///
/// ```swift
/// struct MyView: View {
///     @Environment(StackManager<AppDestination>.self) var nav
///
///     var body: some View {
///         Button("Open Settings") { nav.push(.settings) }
///         Button("Go Back")       { nav.pop() }
///     }
/// }
/// ```
@Observable
public final class StackManager<D: Destination> {
    public var path = NavigationPath()

    public init() {}

    public func push(_ destination: D) {
        path.append(destination)
    }

    public func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    public func popToRoot() {
        path.removeLast(path.count)
    }
}
