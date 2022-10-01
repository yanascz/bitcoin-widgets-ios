import WidgetKit
import SwiftUI
import Intents

struct CombinedStatusView: View {

    var combinedStatus: CombinedStatusProvider.Entry

    var body: some View {
        ZStack {
            BitcoinBackground(family: .systemLarge)
            HStack {
                NodeStatusView(nodeStatus: combinedStatus.nodeStatus)
                    .systemView(for: .systemSmall)
                MempoolStatusView(mempoolStatus: combinedStatus.mempoolStatus)
                    .systemView(for: .systemSmall)
            }
        }
    }

}

struct CombinedStatusView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CombinedStatusView(
                combinedStatus: CombinedStatus(nodeStatus: NodeStatus(blockHeight: 755237, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016),
                mempoolStatus: MempoolStatus(blockHeight: 755237, fastestFee: 17, halfHourFee: 8, hourFee: 3, economyFee: 1, minimumFee: 1))
            ).previewContext(WidgetPreviewContext(family: .systemMedium))
            CombinedStatusView(
                combinedStatus: CombinedStatus(nodeStatus: NodeStatus(blockHeight: 755237, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016),
                mempoolStatus: MempoolStatus(blockHeight: 755237, fastestFee: 2791, halfHourFee: 730, hourFee: 130, economyFee: 37, minimumFee: 19))
            ).previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }

}
