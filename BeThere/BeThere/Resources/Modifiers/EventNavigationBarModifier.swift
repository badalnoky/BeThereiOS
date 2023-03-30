import SwiftUI

public struct EventNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var title: String
    let editAction: () -> Void

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
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image.back
                .fittedToSize(.defaultIconSize)
        }
    }

    @ViewBuilder var editButton: some View {
        Button(action: editAction) {
            Image.edit
                .fittedToSize(.defaultIconSize)
        }
    }
}
