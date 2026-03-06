import SwiftUI

/// Maps each ``Destination`` case to the view that should be displayed.
///
/// Create a struct conforming to this protocol and provide a
/// `view(for:)` method with a switch over your destination enum.
/// Pass an instance of your router to ``Stack`` and ``SheetStack``.
///
/// ```swift
/// struct AppRouter: Router {
///     @ViewBuilder
///     func view(for destination: AppDestination) -> some View {
///         switch destination {
///         case .home:            HomeView()
///         case .settings:        SettingsView()
///         case .profile(let id): ProfileView(userId: id)
///         }
///     }
/// }
/// ```
public protocol Router {
    associatedtype D: Destination
    associatedtype RouteContent: View

    @ViewBuilder func view(for destination: D) -> RouteContent
}
