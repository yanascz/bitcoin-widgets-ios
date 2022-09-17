import WidgetKit
import SwiftUI
import Intents

struct CombinedStatusView: View {

    var combinedStatus: CombinedStatusProvider.Entry

    var body: some View {
        ZStack {
            Color("WidgetBackground")
            Image("Bitcoin")
                .resizable()
                .scaledToFill()
                .opacity(0.07)
                .padding(.trailing)
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
                combinedStatus: CombinedStatus(nodeStatus: NodeStatus(blockHeight: 754091, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016),
                mempoolStatus: MempoolStatus(blockHeight: 754091, fastestFee: 7, halfHourFee: 3, hourFee: 1, minimumFee: 1))
            ).previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }

}
