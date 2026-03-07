import SwiftUI
import Navigation

struct SheetToolbar: ViewModifier {
    @Environment(SheetManager<AppDestination>.self) var sheetManager
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                if let title = sheetManager.destination?.title {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.headline)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetManager.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
    }
}

extension View {
    func sheetToolbar() -> some View {
        modifier(SheetToolbar())
    }
}
