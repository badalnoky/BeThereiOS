import SwiftUI

public struct CachedAsyncImage {
    var urlString: String
    var color: Color
    var size: CGFloat

    public init(
        urlString: String,
        color: Color = .primary,
        size: Double = .defaultImageSize
    ) {
        self.urlString = urlString
        self.color = color
        self.size = size
    }
}

extension CachedAsyncImage: View {
    public var body: some View {
        if let image = ImageCacheService.shared.getImage(for: urlString) {
            image
                .circularFittedToSize(size)
        } else {
            AsyncImage(url: URL(string: urlString)) { image in
                image
                    .circularFittedToSize(size)
                    .task { ImageCacheService.shared.cacheImage(image, with: urlString) }
            } placeholder: {
                Image(systemName: .person)
                    .circularFittedToSize(size)
                    .foregroundColor(color)
            }
        }
    }
}

#if DEBUG
struct AsyncProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedAsyncImage(urlString: .empty)
    }
}
#endif
