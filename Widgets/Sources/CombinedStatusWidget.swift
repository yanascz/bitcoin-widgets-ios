import WidgetKit
import SwiftUI

struct CombinedStatusWidget: Widget {

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "cz.yanas.bitcoin.CombinedStatusWidget", intent: ConfigurationIntent.self, provider: CombinedStatusProvider()) { entry in
            CombinedStatusView(combinedStatus: entry)
        }
        .configurationDisplayName("Combined Status")
        .description("See status of your full node and mempool.space Bitcoin explorer.")
        .supportedFamilies([.systemMedium])
    }

}
