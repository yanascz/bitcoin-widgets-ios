import WidgetKit
import SwiftUI
import Intents

struct CombinedStatusView: View {

    var combinedStatus: CombinedStatusProvider.Entry

    var body: some View {
        if #available(iOSApplicationExtension 17.0, *) {
            HStack(spacing: 42) {
                NodeStatusView(nodeStatus: combinedStatus.nodeStatus)
                    .systemView(for: .systemSmall)
                MempoolStatusView(mempoolStatus: combinedStatus.mempoolStatus)
                    .systemView(for: .systemSmall)
            }.containerBackground(for: .widget) {
                BitcoinBackground(family: .systemLarge, showLogo: combinedStatus.nodeStatus.showBitcoinLogo)
            }
        } else {
            ZStack {
                BitcoinBackground(family: .systemLarge, showLogo: combinedStatus.nodeStatus.showBitcoinLogo)
                HStack {
                    NodeStatusView(nodeStatus: combinedStatus.nodeStatus)
                        .systemView(for: .systemSmall).padding()
                    MempoolStatusView(mempoolStatus: combinedStatus.mempoolStatus)
                        .systemView(for: .systemSmall).padding()
                }
            }
        }
    }

}

struct CombinedStatusView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CombinedStatusView(
                combinedStatus: CombinedStatus(nodeStatus: NodeStatus(showBitcoinLogo: true, blockHeight: 755237, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016),
                mempoolStatus: MempoolStatus(showBitcoinLogo: false, blockHeight: 755237, fastestFee: 17, halfHourFee: 8, hourFee: 3, economyFee: 1, minimumFee: 1))
            ).previewContext(WidgetPreviewContext(family: .systemMedium))
            CombinedStatusView(
                combinedStatus: CombinedStatus(nodeStatus: NodeStatus(showBitcoinLogo: false, blockHeight: 755237, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016),
                mempoolStatus: MempoolStatus(showBitcoinLogo: true, blockHeight: 755237, fastestFee: 2791, halfHourFee: 730, hourFee: 130, economyFee: 37, minimumFee: 19))
            ).previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }

}
