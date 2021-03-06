import Foundation
import WidgetKit

struct MempoolStatus: TimelineEntry {

    let date: Date = Date()
    let blockHeight: Int32
    let fastestFee: Int
    let halfHourFee: Int
    let hourFee: Int
    let minimumFee: Int

}

