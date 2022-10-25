import Foundation

public extension NSRegularExpression {
	convenience init(_ pattern: String) {
		do {
			try self.init(pattern: pattern)
		} catch {
			preconditionFailure("Illegal regular expression: \(pattern).")
		}
	}
	
	func matches(_ string: String) -> Bool {
		let range = NSRange(location: 0, length: string.utf16.count)
		return firstMatch(in: string, options: [], range: range) != nil
	}
	

	
}

public extension String {
	var fromBase64: String? {
		guard let data = Data(base64Encoded: self) else {
			return nil
		}
		
		return String(data: data, encoding: .utf8)
	}
	
	var toBase64: String {
		Data(self.utf8).base64EncodedString()
	}
}

public extension String {
	static func ~= (lhs: String, rhs: String) -> Bool {
		guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
		let range = NSRange(location: 0, length: lhs.utf16.count)
		return regex.firstMatch(in: lhs, options: [], range: range) != nil
	}
	
	func toDate(format: String) -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		formatter.locale = NSLocale(localeIdentifier: "en_us_POSIX") as Locale
		
		return formatter.date(from: self)
	}
}

public extension String {
	
	func groups(for regexPattern: String) -> [[String]] {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let matches = regex.matches(in: text,
										range: NSRange(text.startIndex..., in: text))
			return matches.map { match in
				(0..<match.numberOfRanges).map {
					let rangeBounds = match.range(at: $0)
					guard let range = Range(rangeBounds, in: text) else {
						return ""
					}
					return String(text[range])
				}
			}
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
			return []
		}
	}
}
