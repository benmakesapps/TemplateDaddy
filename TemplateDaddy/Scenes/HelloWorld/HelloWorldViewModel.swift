import Foundation
import Observation

@Observable
@MainActor
final class HelloWorldViewModel {
    struct UIState {
        var isLoading: Bool = false
        var error: (any Error)?
        var greeting: String?
    }

    var state = UIState()

    private let service: HelloWorldServiceProtocol

    init(service: HelloWorldServiceProtocol) {
        self.service = service
    }

    func fetchGreeting(refreshing: Bool = false) async {
        state.isLoading = !refreshing
        state.error = nil
        defer { state.isLoading = false }
        do {
            let model = try await service.getGreeting()
            state.greeting = model.greeting
        } catch {
            state.error = error
        }
    }
}
