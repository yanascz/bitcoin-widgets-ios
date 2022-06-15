import WidgetKit
import SwiftUI

struct MempoolStatusWidget: Widget {

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "cz.yanas.bitcoin.MempoolStatusWidget", provider: MempoolStatusProvider()) { entry in
            MempoolStatusView(mempoolStatus: entry)
        }
        .configurationDisplayName("Mempool Status")
        .description("See status of mempool.space Bitcoin explorer.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }

}
