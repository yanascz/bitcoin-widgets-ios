import WidgetKit
import SwiftUI

@main
struct BitcoinWidgets: WidgetBundle {

    @WidgetBundleBuilder
    var body: some Widget {
        NodeStatusWidget()
        MempoolStatusWidget()
        CombinedStatusWidget()
    }

}
