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
        IntentConfiguration(kind: "cz.yanas.bitcoin.MempoolStatusWidget", intent: MempoolConfigurationIntent.self, provider: MempoolStatusProvider()) { entry in
            MempoolStatusView(mempoolStatus: entry)
        }
        .configurationDisplayName("MempoolStatusWidget.displayName")
        .description("MempoolStatusWidget.description")
        .supportedFamilies(supportedFamilies)
    }

}
