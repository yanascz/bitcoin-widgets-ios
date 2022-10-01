import WidgetKit
import SwiftUI
import Intents

struct NodeStatusView: View {

    @Environment(\.widgetFamily) var family: WidgetFamily
    var nodeStatus: NodeStatusProvider.Entry

    var body: some View {
        if #available(iOSApplicationExtension 16.0, *), family == .accessoryRectangular || family == .accessoryInline {
            accessoryView(for: family)
        } else {
            ZStack {
                BitcoinBackground(family: family)
                systemView(for: family)
            }
        }
    }

    @available(iOSApplicationExtension 16.0, *)
    func accessoryView(for family: WidgetFamily) -> some View {
        VStack(alignment: .trailing) {
            if let blockHeight = nodeStatus.blockHeight,
               let userAgent = nodeStatus.userAgent,
               let protocolVersion = nodeStatus.protocolVersion {
                if family == .accessoryInline {
                    Label(String(blockHeight), systemImage: "bitcoinsign.square.fill")
                } else {
                    Text(String(blockHeight))
                        .font(.system(size: 37))
                    Text("\(userAgent)\(String(protocolVersion))")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.trailing, 2)
                }
            } else if let error = nodeStatus.error {
                if family == .accessoryInline {
                    Label(error.localizedDescription, systemImage: "exclamationmark.triangle.fill")
                } else {
                    Text(error.localizedDescription)
                }
            }
        }
    }

    func systemView(for family: WidgetFamily) -> some View {
        VStack(alignment: family == .systemSmall ? .trailing : .center) {
            if let blockHeight = nodeStatus.blockHeight,
               let userAgent = nodeStatus.userAgent,
               let protocolVersion = nodeStatus.protocolVersion {
                Text(String(blockHeight))
                    .font(family == .systemSmall ? .title : .largeTitle)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.bottom, 1)
                VStack(alignment: .trailing) {
                    Text(userAgent)
                    Text("(\(String(protocolVersion)))")
                }.font(family == .systemSmall ? .footnote : .body)
                    .foregroundColor(.gray)
                    .padding(.trailing, family == .systemSmall ? 2 : 0)
            } else if let error = nodeStatus.error {
                Text(error.localizedDescription)
                    .foregroundColor(Color.white)
            }
        }.padding()
    }

}

struct NodeStatusView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            NodeStatusView(nodeStatus: NodeStatus(error: .configurationRequired))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            NodeStatusView(nodeStatus: NodeStatus(error: .nodeUnreachable))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            NodeStatusView(nodeStatus: NodeStatus(blockHeight: 754091, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            NodeStatusView(nodeStatus: NodeStatus(error: .configurationRequired))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            NodeStatusView(nodeStatus: NodeStatus(error: .nodeUnreachable))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            NodeStatusView(nodeStatus: NodeStatus(blockHeight: 754091, userAgent: "/Satoshi:22.99.0/", protocolVersion: 70016))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            if #available(iOSApplicationExtension 16.0, *) {
                NodeStatusView(nodeStatus: NodeStatus(error: .configurationRequired))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                NodeStatusView(nodeStatus: NodeStatus(error: .nodeUnreachable))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                NodeStatusView(nodeStatus: NodeStatus(blockHeight: 754091, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))

                NodeStatusView(nodeStatus: NodeStatus(error: .configurationRequired))
                    .previewContext(WidgetPreviewContext(family: .accessoryInline))
                NodeStatusView(nodeStatus: NodeStatus(error: .nodeUnreachable))
                    .previewContext(WidgetPreviewContext(family: .accessoryInline))
                NodeStatusView(nodeStatus: NodeStatus(blockHeight: 754091, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016))
                    .previewContext(WidgetPreviewContext(family: .accessoryInline))
            }
        }
    }

}
