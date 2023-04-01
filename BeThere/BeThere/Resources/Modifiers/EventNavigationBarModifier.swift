import SwiftUI

public struct EventNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var title: String
    let editAction: () -> Void

    init(title: String, editAction: @escaping () -> Void) {
        self.title = title
        self.editAction = editAction

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(.appBackground)
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    public func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { backButton }
                ToolbarItem(placement: .principal) { Text(title).textStyle(.largeTitle) }
                ToolbarItem(placement: .navigationBarTrailing) { editButton }
            }
    }
}

extension EventNavigationBarModifier {
    @ViewBuilder var backButton: some View {
        IconButton(.back) {
            presentationMode.wrappedValue.dismiss()
        }
    }

    @ViewBuilder var editButton: some View {
        IconButton(.edit, action: editAction)
    }
}
