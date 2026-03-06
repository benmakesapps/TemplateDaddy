import Foundation
import Observation

/// Manages modal sheet presentation for a ``SheetStack``.
///
/// You don't create this yourself — ``SheetStack`` creates one and injects it
/// into the SwiftUI environment. Grab it from any child view to
/// show or dismiss a sheet.
///
/// ```swift
/// struct MyView: View {
///     @Environment(SheetManager<AppDestination>.self) var sheet
///
///     var body: some View {
///         Button("Open Settings") { sheet.show(.settings) }
///         Button("Close")         { sheet.dismiss() }
///     }
/// }
/// ```
@Observable
public final class SheetManager<D: Destination> {
    public var destination: D?

    public init() {}

    public func show(_ destination: D) {
        self.destination = destination
    }

    public func dismiss() {
        destination = nil
    }
}
