import WidgetKit
import SwiftUI

struct NodeStatusWidget: Widget {

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "cz.yanas.bitcoin.NodeStatusWidget", intent: ConfigurationIntent.self, provider: NodeStatusProvider()) { entry in
            NodeStatusView(nodeStatus: entry)
        }
        .configurationDisplayName("Node Status")
        .description("See status of your full node.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }

}
