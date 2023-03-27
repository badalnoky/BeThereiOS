import PhotosUI
import SwiftUI

public struct ImagePicker: View {
    private var size: Double
    private var selectedImage: Binding<UIImage?>

    @State private var selectedItem: PhotosPickerItem?

    public var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            if let image = selectedImage.wrappedValue {
                Image(uiImage: image)
                    .circularFittedToSize(size)
            } else {
                Image(systemName: .person)
                    .circularFittedToSize(size)
            }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                    selectedImage.wrappedValue = uiImage
                }
            }
        }
    }

    public init(size: Double, image: Binding<UIImage?>) {
        self.size = size
        self.selectedImage = image
    }
}

#if DEBUG
struct ImagePicker_Previews: PreviewProvider {
    @State static var image: UIImage? = UIImage(systemName: .person)
    static var previews: some View {
        ImagePicker(size: .defaultImageSize, image: $image)
    }
}
#endif
