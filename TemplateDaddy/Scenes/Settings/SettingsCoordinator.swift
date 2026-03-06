import SwiftUI

struct SettingsCoordinator: View {
    @Environment(ServiceProvider.self) private var services

    var viewModel: SettingsViewModel {
        SettingsViewModel()
    }

    var body: some View {
        SettingsView(viewModel: viewModel)
            .styledToolbar(.sheet)
    }
}
