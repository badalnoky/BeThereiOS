import SwiftUI

public struct DefaultNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var title: String
    var isNavigatable: Bool

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
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image.back
                .fittedToSize(.defaultIconSize)
        }
    }
}
