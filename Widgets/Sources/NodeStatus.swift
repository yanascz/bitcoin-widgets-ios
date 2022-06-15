import Foundation
import WidgetKit

struct NodeStatus: TimelineEntry {

    let date: Date = Date()
    let protocolVersion: Int32?
    let userAgent: String?
    let blockHeight: Int32?
    let error: Error?

    init(protocolVersion: Int32, userAgent: String, blockHeight: Int32) {
        self.protocolVersion = protocolVersion
        self.userAgent = userAgent
        self.blockHeight = blockHeight
        self.error = nil
    }

    init(error: Error) {
        self.protocolVersion = nil
        self.userAgent = nil
        self.blockHeight = nil
        self.error = error
    }

    enum Error: String {
        case configurationRequired = "Configuration required"
        case nodeUnreachable = "Node unreachable"
    }

}

