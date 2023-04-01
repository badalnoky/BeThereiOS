import PhotosUI
import SwiftUI

public struct AsyncImagePicker: View {
    private var url: String
    private var size: Double
    private var color: Color
    private var selectedImage: Binding<UIImage?>
    private var hasChanged: Binding<Bool>

    @State private var selectedItem: PhotosPickerItem?

    public var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            if let image = selectedImage.wrappedValue {
                Image(uiImage: image)
                    .circularFittedToSize(size)
            } else {
                CachedAsyncImage(urlString: url, color: color, size: size)
            }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                    selectedImage.wrappedValue = uiImage
                    hasChanged.wrappedValue = true
                }
            }
        }
    }

    public init(
        url: String,
        color: Color = .primary,
        size: Double,
        image: Binding<UIImage?>,
        hasChanged: Binding<Bool>
    ) {
        self.url = url
        self.color = color
        self.size = size
        self.selectedImage = image
        self.hasChanged = hasChanged
    }
}

#if DEBUG
struct ImagePicker_Previews: PreviewProvider {
    @State static var image: UIImage? = UIImage(systemName: .person)
    @State static var hasChanged = false
    static var previews: some View {
        AsyncImagePicker(url: .empty, size: .defaultImageSize, image: $image, hasChanged: $hasChanged)
    }
}
#endif
