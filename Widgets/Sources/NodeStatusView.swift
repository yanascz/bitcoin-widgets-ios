import WidgetKit
import SwiftUI
import Intents

struct NodeStatusView: View {

    @Environment(\.widgetFamily) var family: WidgetFamily
    var nodeStatus: NodeStatusProvider.Entry

    var body: some View {
        ZStack {
            Color("WidgetBackground")
            Image("Bitcoin")
                .resizable()
                .opacity(0.07)
                .aspectRatio(contentMode: family == .systemSmall ? .fit : .fill)
                .padding(family == .systemSmall ? .all : .trailing)
            content(for: family)
        }
    }

    func content(for family: WidgetFamily) -> some View {
        VStack(alignment: family == .systemSmall ? .trailing : .center) {
            if let blockHeight = nodeStatus.blockHeight,
               let userAgent = nodeStatus.userAgent,
               let protocolVersion = nodeStatus.protocolVersion {
                Text(String(blockHeight))
                    .font(family == .systemSmall ? .title : .largeTitle)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.bottom, 1)
                Text("\(userAgent)\n(\(String(protocolVersion)))")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, family == .systemSmall ? 2 : 0)
            } else if let error = nodeStatus.error {
                Text(error.rawValue)
                    .foregroundColor(Color.white)
            }
        }.padding()
    }

}

struct NodeStatusView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            NodeStatusView(nodeStatus: NodeStatus(blockHeight: 740597, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            NodeStatusView(nodeStatus: NodeStatus(blockHeight: 740597, userAgent: "/Satoshi:22.99.0/", protocolVersion: 70016))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            NodeStatusView(nodeStatus: NodeStatus(error: .configurationRequired))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            NodeStatusView(nodeStatus: NodeStatus(error: .configurationRequired))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            NodeStatusView(nodeStatus: NodeStatus(error: .nodeUnreachable))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            NodeStatusView(nodeStatus: NodeStatus(error: .nodeUnreachable))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }

}
