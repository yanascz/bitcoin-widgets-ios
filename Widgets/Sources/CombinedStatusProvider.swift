import Foundation
import WidgetKit

struct CombinedStatusProvider: IntentTimelineProvider {

    private let nodeStatusProvider = NodeStatusProvider()
    private let mempoolStatusProvider = MempoolStatusProvider()

    func placeholder(in context: Context) -> CombinedStatus {
        return CombinedStatus(
            nodeStatus: nodeStatusProvider.placeholder(in: context),
            mempoolStatus: mempoolStatusProvider.placeholder(in: context)
        )
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (CombinedStatus) -> ()) {
        if context.isPreview {
            completion(placeholder(in: context))
            return
        }

        Task.init {
            completion(try await getCombinedStatus(for: configuration))
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<CombinedStatus>) -> ()) {
        Task.init {
            let combinedStatus = try await getCombinedStatus(for: configuration)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
            completion(Timeline(entries: [combinedStatus], policy: .after(nextUpdate)))
        }
    }

    func getCombinedStatus(for configuration: ConfigurationIntent) async throws -> CombinedStatus {
        let nodeStatus = await nodeStatusProvider.getNodeStatus(for: configuration)
        let mempoolStatus = try await mempoolStatusProvider.getMempoolStatus()

        return CombinedStatus(nodeStatus: nodeStatus, mempoolStatus: mempoolStatus)
    }

}
