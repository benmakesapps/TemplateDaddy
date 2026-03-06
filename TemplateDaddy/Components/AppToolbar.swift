import SwiftUI
import Navigation

struct AppToolbar: ViewModifier {
    @Environment(SheetManager<AppDestination>.self) private var sheetManager
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(systemName: "globe.desk")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetManager.show(.settings)
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
    }
}

extension View {
    func appToolbar() -> some View {
        modifier(AppToolbar())
    }
}
