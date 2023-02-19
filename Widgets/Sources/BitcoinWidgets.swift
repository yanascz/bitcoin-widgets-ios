import WidgetKit
import SwiftUI

@main
struct BitcoinWidgets: WidgetBundle {

    @WidgetBundleBuilder
    var body: some Widget {
#if !os(watchOS)
        NodeStatusWidget()
#endif
        MempoolStatusWidget()
#if !os(watchOS)
        CombinedStatusWidget()
#endif
        MoscowTimeWidget()
    }

}
