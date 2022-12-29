import Foundation

class MoscowTimeFormatter: Formatter {

    var format: MoscowTimeFormat = .time

    override func string(for object: Any?) -> String {
        if let value = object as? Double {
            let satsPerUnit = Int(100_000_000 / value)

            switch format {
                case .time:
                    return String(format: "%i:%02i", satsPerUnit / 100, satsPerUnit % 100)
                case .plain:
                    return String(satsPerUnit)
                case .unknown:
                    return "?"
            }
        }
        return "?"
    }

}

