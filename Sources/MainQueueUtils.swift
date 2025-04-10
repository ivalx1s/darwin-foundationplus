import Foundation

/// Runs a block of code using DispatchQueue's asyncAfter method on Main queue.
///
/// ❗️Mind the capture semantics; *action* is captured immediately on *delay* call.
/// - parameter delayTime: time in seconds to wait until execution starts
/// - parameter action: a block of code to execute
public func delay(for delayTime: Double?, action: @Sendable @escaping  () -> Void) {
    let delay = delayTime ?? 0.0
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        action()
    }
}

/// Runs a block of code using DispatchQueue's asyncAfter method on Main queue.
///
/// ❗️Mind the capture semantics; *action* is captured immediately on *delay* call.
/// - parameter delayTime: a time to whait until execution starts
/// - parameter action: a block of code to execute
public func delay(_ delayTime: Double = 0.0, action: @Sendable @escaping  () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
        action()
    }
}

public func exec(action: @Sendable @escaping  () -> Void) {
    DispatchQueue.main.async {
        action()
    }
}
