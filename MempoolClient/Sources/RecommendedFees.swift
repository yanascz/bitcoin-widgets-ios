import Foundation

struct RecommendedFees: Decodable {
    let fastestFee: Int
    let halfHourFee: Int
    let hourFee: Int
    let minimumFee: Int
}
