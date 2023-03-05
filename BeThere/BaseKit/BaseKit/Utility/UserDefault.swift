import Foundation

@propertyWrapper
struct UserDefault<K: RawRepresentable<String>, V: Codable> {
    let key: K

    var wrappedValue: V? {
        get {
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data
            else { return nil }
            return try? JSONDecoder().decode(V.self, from: data)
        }

        set {
            if let newValue = newValue, let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key.rawValue)
            } else {
                UserDefaults.standard.removeObject(forKey: key.rawValue)
            }
            UserDefaults.standard.synchronize()
        }
    }

    init(key: K) {
        self.key = key
        print(Mirror(reflecting: self).description)
    }
}
