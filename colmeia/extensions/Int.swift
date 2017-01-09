import Foundation

extension Int {
    private struct Constants {
        static let secondsInHours = 3600
        static let secondsInMinutes = 60
    }

    func times<T>(closure: () -> T) -> [T] {
        return (0 ..< self).map { _ in closure() }
    }
}
