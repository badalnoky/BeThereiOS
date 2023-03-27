import SwiftUI

extension Image {
    func circularFittedToSize(_ size: Double) -> some View {
        self
            .resizable()
            .frame(width: size, height: size)
            .scaledToFill()
            .clipShape(Circle())
    }
}
