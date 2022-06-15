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
                    .content(for: .systemSmall)
                MempoolStatusView(mempoolStatus: combinedStatus.mempoolStatus)
                    .content(for: .systemSmall)
            }
        }
    }

}

struct CombinedStatusView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CombinedStatusView(combinedStatus: CombinedStatus(nodeStatus: NodeStatus(protocolVersion: 70016, userAgent: "/Satoshi:23.0.0/", blockHeight: 740597), mempoolStatus: MempoolStatus(blockHeight: 740597, fastestFee: 7, halfHourFee: 3, hourFee: 1, minimumFee: 1)))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }

}
