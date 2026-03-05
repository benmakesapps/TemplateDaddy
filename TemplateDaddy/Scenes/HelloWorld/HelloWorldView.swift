import SwiftUI

struct HelloWorldView: View {
    var viewModel: HelloWorldViewModel

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.state.isLoading {
                    ProgressView()
                } else if let error = viewModel.state.error {
                    Text(error.localizedDescription)
                } else if let greeting = viewModel.state.greeting {
                    Text(greeting)
                } else {
                    Image(systemName: "face.smiling")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .task {
            await viewModel.fetchGreeting()
        }
        .refreshable {
            await viewModel.fetchGreeting(refreshing: true)
        }
    }
}
