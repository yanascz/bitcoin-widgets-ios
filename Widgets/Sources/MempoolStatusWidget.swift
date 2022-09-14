import WidgetKit
import SwiftUI

struct MempoolStatusWidget: Widget {

    let supportedFamilies: [WidgetFamily];

    init() {
        if #available(iOSApplicationExtension 16.0, *) {
            self.supportedFamilies = [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryInline]
        } else {
            self.supportedFamilies = [.systemSmall, .systemMedium]
        }
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "cz.yanas.bitcoin.MempoolStatusWidget", provider: MempoolStatusProvider()) { entry in
            MempoolStatusView(mempoolStatus: entry)
        }
        .configurationDisplayName("Mempool Status")
        .description("See status of mempool.space Bitcoin explorer.")
        .supportedFamilies(supportedFamilies)
    }

}
