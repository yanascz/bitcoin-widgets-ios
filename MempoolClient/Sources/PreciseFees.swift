import Foundation

struct PreciseFees: Decodable {
    let fastestFee: Double
    let halfHourFee: Double
    let hourFee: Double
    let economyFee: Double
    let minimumFee: Double
}
