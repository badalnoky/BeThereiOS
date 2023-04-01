import SwiftUI

public extension Image {
    func fittedToSize(_ size: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

public extension Image {
    func circularFittedToSize(_ size: Double) -> some View {
        self
            .resizable()
            .frame(width: size, height: size)
            .scaledToFill()
            .clipShape(Circle())
    }
}
