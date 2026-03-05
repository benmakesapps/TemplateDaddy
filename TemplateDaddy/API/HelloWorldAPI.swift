import Foundation

struct HelloWorldResponse: Decodable {
    let message: String
}

protocol HelloWorldAPIProtocol {
    func fetchHello() async throws -> HelloWorldResponse
}

final class HelloWorldAPI: HelloWorldAPIProtocol {
    func fetchHello() async throws -> HelloWorldResponse {
        // Stubbed — swap this body for a real URLSession call when ready
        try await Task.sleep(for: .seconds(2))
        return HelloWorldResponse(message: "Hello, World!")
    }
}
