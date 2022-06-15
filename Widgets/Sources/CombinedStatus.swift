import Foundation
import WidgetKit

struct CombinedStatus: TimelineEntry {

    let date: Date = Date()
    let nodeStatus: NodeStatus
    let mempoolStatus: MempoolStatus

}
