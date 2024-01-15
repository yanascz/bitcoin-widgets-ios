import WidgetKit
import SwiftUI

struct HalvingCountdownWidget: Widget {

    let supportedFamilies: [WidgetFamily];

    init() {
#if os(watchOS)
        self.supportedFamilies = [.accessoryRectangular]
#else
        if #available(iOSApplicationExtension 16.0, *) {
            self.supportedFamilies = [.systemSmall, .systemMedium, .accessoryRectangular]
        } else {
            self.supportedFamilies = [.systemSmall, .systemMedium]
        }
#endif
    }

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "cz.yanas.bitcoin.HalvingCountdownWidget", intent: MempoolConfigurationIntent.self, provider: HalvingCountdownProvider()) { entry in
            HalvingCountdownView(halvingCountdown: entry)
        }
        .configurationDisplayName("HalvingCountdownWidget.displayName")
        .description("HalvingCountdownWidget.description")
        .supportedFamilies(supportedFamilies)
    }
}
