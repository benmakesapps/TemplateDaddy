import SwiftUI

struct HelloWorldCoordinator: View {
    @Environment(ServiceProvider.self) private var services

    var viewModel: HelloWorldViewModel {
        HelloWorldViewModel(service: services.helloWorldService)
    }

    var body: some View {
        HelloWorldView(viewModel: viewModel)
    }
}
