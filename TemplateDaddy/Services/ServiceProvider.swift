import Observation

@Observable
final class ServiceProvider {
    let helloWorldService: HelloWorldServiceProtocol

    init(helloWorldService: HelloWorldServiceProtocol = HelloWorldService()) {
        self.helloWorldService = helloWorldService
    }
}
