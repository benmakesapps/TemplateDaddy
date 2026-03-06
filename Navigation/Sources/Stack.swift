import SwiftUI

/// A wrapper around `NavigationStack` that pairs with a ``Router``
/// to handle push navigation.
///
/// A ``StackManager`` is created automatically and injected into the
/// environment. Any child view can grab it to push, pop, or return
/// to root.
///
/// ```swift
/// Stack(router: AppRouter()) {
///     HomeView()
/// }
/// ```
public struct Stack<R: Router, C: View>: View {
    @State private var stackManager = StackManager<R.D>()
    private let router: R
    @ViewBuilder private let content: C

    public init(
        router: R,
        @ViewBuilder content: () -> C
    ) {
        self.router = router
        self.content = content()
    }

    public var body: some View {
        @Bindable var stackManager = stackManager

        NavigationStack(path: $stackManager.path) {
            content
                .navigationDestination(for: R.D.self) { destination in
                    router.view(for: destination)
                }
        }
        .environment(stackManager)
    }
}
