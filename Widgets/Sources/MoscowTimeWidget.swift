import WidgetKit
import SwiftUI

struct MoscowTimeWidget: Widget {

    let supportedFamilies: [WidgetFamily];

    init() {
#if os(watchOS)
        self.supportedFamilies = [.accessoryRectangular, .accessoryInline]
#else
        if #available(iOSApplicationExtension 16.0, *) {
            self.supportedFamilies = [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryInline]
        } else {
            self.supportedFamilies = [.systemSmall, .systemMedium]
        }
#endif
    }

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "cz.yanas.bitcoin.MoscowTimeWidget", intent: MoscowTimeConfigurationIntent.self, provider: MoscowTimeProvider()) { entry in
            MoscowTimeView(moscowTime: entry)
        }
        .configurationDisplayName("MoscowTimeWidget.displayName")
        .description("MoscowTimeWidget.description")
        .supportedFamilies(supportedFamilies)
    }

}
