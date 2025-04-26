import Foundation

public extension Int {
    var localized: String {
        return self.formatted(.number)
    }
}
