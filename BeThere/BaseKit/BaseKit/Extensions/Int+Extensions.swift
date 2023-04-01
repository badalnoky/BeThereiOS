public extension Int {
    static let defaultImageCacheSize = 25
}

public extension Int {
    var previous: Int {
        self - 1
    }

    var next: Int {
        self + 1
    }
}
