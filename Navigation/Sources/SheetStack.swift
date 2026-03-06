import SwiftUI

/// A view modifier that enables modal sheet navigation using a ``Router``.
///
/// Apply `.sheetStack(router:)` to the root of your view hierarchy.
/// A ``SheetManager`` is created automatically and injected into the
/// environment. Any child view can grab it to present or dismiss sheets.
/// Each sheet is hosted in its own ``Stack`` so push navigation
/// works inside modals too.
///
/// ```swift
/// Stack(router: router) {
///     HomeView()
/// }
/// .sheetStack(router: router)
/// ```
public struct SheetStack<R: Router>: ViewModifier {
    @State var sheetManager = SheetManager<R.D>()
    let router: R

    public init(router: R) {
        self.router = router
    }

    public func body(content: Content) -> some View {
        @Bindable var manager = sheetManager
        Group {
            content
                .sheet(item: $manager.destination) { destination in
                    Stack(router: router) {
                        router.view(for: destination)
                    }
                }
        }
        .environment(manager)
    }
}

public extension View {
    func sheetStack<R: Router>(
        router: R
    ) -> some View {
        modifier(SheetStack(router: router))
    }
}
