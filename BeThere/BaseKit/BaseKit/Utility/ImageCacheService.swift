import SwiftUI

public final class ImageCacheService {
    public static var shared: ImageCacheService = .init()

    private var maxSize: Int = .defaultImageCacheSize
    private var cache: [String: Image] = [:]
    private var keyQueue: [String] = []

    private init() {}

    public func getImage(for key: String) -> Image? {
        cache[key]
    }

    public func cacheImage(_ image: Image, with key: String) {
        if cache.keys.contains(key) {
            keyQueue.removeAll { $0 == key }
        } else if cache.keys.count >= maxSize {
            let removed = keyQueue.removeLast()
            cache[removed] = nil
        }
        cache[key] = image
        keyQueue.insert(key, at: 0)
    }
}
