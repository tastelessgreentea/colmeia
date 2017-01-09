import UIKit

@discardableResult
public func clamp01(value: Float) -> Float {
    return min(max(value, 0), 1)
}

@discardableResult
public func clamp01(value: CGFloat) -> CGFloat {
    return min(max(value, 0), 1)
}

@discardableResult
public func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}
