import SwiftUI

public struct DefaultNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var title: String
    var isNavigatable: Bool

    init(title: String, isNavigatable: Bool) {
        self.title = title
        self.isNavigatable = isNavigatable

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
                if isNavigatable {
                    ToolbarItem(placement: .navigationBarLeading) { backButton }
                }
                ToolbarItem(placement: .principal) {
                    Text(title).textStyle(.largeTitle)
                }
            }
    }
}

extension DefaultNavigationBarModifier {
    @ViewBuilder var backButton: some View {
        IconButton(.back) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
