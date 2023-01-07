import WidgetKit
import SwiftUI

struct CombinedStatusWidget: Widget {

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "cz.yanas.bitcoin.CombinedStatusWidget", intent: NodeConfigurationIntent.self, provider: CombinedStatusProvider()) { entry in
            CombinedStatusView(combinedStatus: entry)
        }
        .configurationDisplayName("CombinedStatusWidget.displayName")
        .description("CombinedStatusWidget.description")
        .supportedFamilies([.systemMedium])
    }

}
