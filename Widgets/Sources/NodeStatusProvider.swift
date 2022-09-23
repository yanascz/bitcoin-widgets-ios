import Foundation
import WidgetKit

struct NodeStatusProvider: IntentTimelineProvider {

    private let bitnodesClient = BitnodesClient()

    func placeholder(in context: Context) -> NodeStatus {
        return NodeStatus(blockHeight: 755374, userAgent: "/Satoshi:23.0.0/", protocolVersion: 70016)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (NodeStatus) -> ()) {
        if context.isPreview {
            completion(placeholder(in: context))
            return
        }

        Task.init {
            completion(await getNodeStatus(for: configuration))
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<NodeStatus>) -> ()) {
        Task.init {
            let nodeStatus = await getNodeStatus(for: configuration)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
            completion(Timeline(entries: [nodeStatus], policy: .after(nextUpdate)))
        }
    }

    func getNodeStatus(for configuration: ConfigurationIntent) async -> NodeStatus {
        if configuration.host == nil || configuration.port == nil {
            return NodeStatus(error: .configurationRequired)
        }

        let host = configuration.host!
        let port = Int(truncating: configuration.port!)

        if host.hasSuffix(".onion") {
            guard let cachedStatus = try? await bitnodesClient.getNodeStatus(host: host, port: port),
                  let currentStatus = try? await bitnodesClient.checkNode(host: host, port: port) else {
                return NodeStatus(error: .nodeUnreachable)
            }

            return NodeStatus(
                blockHeight: currentStatus.height,
                userAgent: cachedStatus.userAgent,
                protocolVersion: cachedStatus.protocolVersion
            )
        }

        let client = BitcoinClient(host: host, port: port)

        guard let versionMessage = try? await client.getVersionMessage() else {
            return NodeStatus(error: .nodeUnreachable)
        }

        return NodeStatus(
            blockHeight: versionMessage.blockHeight,
            userAgent: versionMessage.userAgent,
            protocolVersion: versionMessage.protocolVersion
        )
    }

}
