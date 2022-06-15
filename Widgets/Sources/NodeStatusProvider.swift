import Foundation
import WidgetKit

struct NodeStatusProvider: IntentTimelineProvider {

    private let bitnodesClient = BitnodesClient()

    func placeholder(in context: Context) -> NodeStatus {
        return NodeStatus(protocolVersion: 70016, userAgent: "/Satoshi:23.0.0/", blockHeight: 740597)
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
                protocolVersion: cachedStatus.protocolVersion,
                userAgent: cachedStatus.userAgent,
                blockHeight: currentStatus.height
            )
        }

        let client = BitcoinClient(host: host, port: port)

        guard let versionMessage = try? await client.getVersionMessage() else {
            return NodeStatus(error: .nodeUnreachable)
        }

        return NodeStatus(
            protocolVersion: versionMessage.protocolVersion,
            userAgent: versionMessage.userAgent,
            blockHeight: versionMessage.blockHeight
        )
    }

}
