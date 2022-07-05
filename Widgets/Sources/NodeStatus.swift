import Foundation
import WidgetKit

struct NodeStatus: TimelineEntry {

    let date: Date = Date()
    let blockHeight: Int32?
    let userAgent: String?
    let protocolVersion: Int32?
    let error: Error?

    init(blockHeight: Int32, userAgent: String, protocolVersion: Int32) {
        self.blockHeight = blockHeight
        self.userAgent = userAgent
        self.protocolVersion = protocolVersion
        self.error = nil
    }

    init(error: Error) {
        self.blockHeight = nil
        self.userAgent = nil
        self.protocolVersion = nil
        self.error = error
    }

    enum Error: String {
        case configurationRequired = "Configuration required"
        case nodeUnreachable = "Node unreachable"
    }

}

