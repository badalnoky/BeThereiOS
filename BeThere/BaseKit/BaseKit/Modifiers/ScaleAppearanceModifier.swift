import SwiftUI

struct ScaleAppearanceModifier: ViewModifier {
    @State var scale: Double = .zero

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: .defaultAnimationDuration)) {
                    scale = .one
                }
            }
    }
}
