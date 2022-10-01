import WidgetKit
import SwiftUI

struct MoscowTimeWidget: Widget {

    let supportedFamilies: [WidgetFamily];

    init() {
        if #available(iOSApplicationExtension 16.0, *) {
            self.supportedFamilies = [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryInline]
        } else {
            self.supportedFamilies = [.systemSmall, .systemMedium]
        }
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "cz.yanas.bitcoin.MoscowTimeWidget", provider: MoscowTimeProvider()) { entry in
            MoscowTimeView(moscowTime: entry)
        }
        .configurationDisplayName("MoscowTimeWidget.displayName")
        .description("MoscowTimeWidget.description")
        .supportedFamilies(supportedFamilies)
    }

}
