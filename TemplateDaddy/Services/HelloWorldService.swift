import Foundation

// Domain model — decoupled from the API response shape
struct HelloWorldModel {
    let greeting: String
}

protocol HelloWorldServiceProtocol {
    func getGreeting() async throws -> HelloWorldModel
}

final class HelloWorldService: HelloWorldServiceProtocol {
    private let api: HelloWorldAPIProtocol

    init(api: HelloWorldAPIProtocol = HelloWorldAPI()) {
        self.api = api
    }

    func getGreeting() async throws -> HelloWorldModel {
        let response = try await api.fetchHello()
        // Transform API response → domain model here as needed
        return HelloWorldModel(greeting: response.message)
    }
}
