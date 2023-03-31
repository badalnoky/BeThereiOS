import Lottie
import SwiftUI

public struct Lottie: UIViewRepresentable {
    private let animation: String
    private let animationView = LottieAnimationView()

    public init(named animation: String) {
        self.animation = animation
    }

    public func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)

        animationView.animation = LottieAnimation.asset(animation)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {}
}
