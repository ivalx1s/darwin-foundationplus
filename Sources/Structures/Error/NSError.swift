import Foundation

public struct AppNSError: IAppError {
    public let sender: Any.Type
    public let callStack: [String]
    public let error: Error? = nil
    public let message: String
    public let violation: ErrorViolation
    public let exception: NSException

    public var conciseDescription: String {
        "\(violation) from \(sender); \(message)"
    }

    public var description: String {
        conciseDescription
    }

    public var debugDescription: String {
        conciseDescription
    }

    public init(
            sender: Any,
            message: String,
            violation: ErrorViolation,
            exception: NSException
    ) {
        self.sender = Mirror(reflecting: sender).subjectType
        self.callStack = exception.callStackSymbols
        self.message = message
        self.violation = violation
        self.exception = exception
    }

    public func toString() -> String {
        data.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
    }

    public var data: [String: String] {
        [
            "sender": "\(sender)",
            "message": "\(exception.name)",
            "violation": violation.rawValue,
            "cause": exception.reason ?? "",
            "callStack": "\n\(callStack.joined(separator: "\n"))"
        ]
    }
}
