import Foundation
import WidgetKit

struct MempoolStatus: TimelineEntry {

    let date: Date = Date()
    let showBitcoinLogo: Bool
    let blockHeight: Int32
    let fastestFee: Int
    let halfHourFee: Int
    let hourFee: Int
    let economyFee: Int
    let minimumFee: Int

}
