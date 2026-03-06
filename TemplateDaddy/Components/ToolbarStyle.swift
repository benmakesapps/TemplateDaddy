import SwiftUI

enum ToolbarStyle {
    case app
    case sheet
}

extension View {
    @ViewBuilder
    func styledToolbar(_ style: ToolbarStyle) -> some View {
        switch style {
        case .app:
            self.appToolbar()
        case .sheet:
            self.sheetToolbar()
        }
    }
}
