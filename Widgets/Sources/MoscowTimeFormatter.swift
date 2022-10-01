import Foundation

class MoscowTimeFormatter: Formatter {

    override func string(for object: Any?) -> String {
        if let value = object as? Double {
            return String(Int(100_000_000 / value))
        }
        return "?"
    }

}

