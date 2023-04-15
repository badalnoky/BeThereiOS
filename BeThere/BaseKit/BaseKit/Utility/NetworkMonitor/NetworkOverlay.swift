import SwiftUI

struct NetworkOverlay: View {
    @StateObject var viewModel = NetworkMonitorViewModel()
    var body: some View {
        if viewModel.displayAlert {
            ZStack {
                Color.white.opacity(.zero)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                VStack(spacing: .padding16) {
                    Image(systemName: .networkErrorIcon)
                        .fittedToSize(.mediumIconSize)
                        .foregroundColor(.red)

                    Text(String.networkErrorDescription)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .bold()
                }
                .padding(.padding56)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: .padding16).fill(.ultraThinMaterial))
                .padding(.horizontal, .padding8)
            }
            .transition(.move(edge: .bottom))
        }
    }
}
