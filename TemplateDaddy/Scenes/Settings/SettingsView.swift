import SwiftUI

struct SettingsView: View {
    var viewModel: SettingsViewModel

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.state.isLoading {
                    ProgressView()
                } else if let error = viewModel.state.error {
                    Text(error.localizedDescription)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
