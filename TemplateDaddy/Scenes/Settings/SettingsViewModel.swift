import Foundation
import Observation

@Observable
@MainActor
final class SettingsViewModel {
    struct UIState {
        var isLoading: Bool = false
        var error: (any Error)?
    }

    var state = UIState()
}
