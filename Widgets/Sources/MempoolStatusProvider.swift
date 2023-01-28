import Foundation
import WidgetKit

struct MempoolStatusProvider: IntentTimelineProvider {

    private let mempoolClient = MempoolClient()

    func placeholder(in context: Context) -> MempoolStatus {
        return MempoolStatus(showBitcoinLogo: true, blockHeight: 756569, fastestFee: 17, halfHourFee: 8, hourFee: 3, economyFee: 1, minimumFee: 1)
    }

    func getSnapshot(for configuration: MempoolConfigurationIntent, in context: Context, completion: @escaping (MempoolStatus) -> ()) {
        if context.isPreview {
            completion(placeholder(in: context))
            return
        }

        Task.init {
            completion(try await getMempoolStatus(showBitcoinLogo: configuration.showBitcoinLogo))
        }
    }

    func getTimeline(for configuration: MempoolConfigurationIntent, in context: Context, completion: @escaping (Timeline<MempoolStatus>) -> ()) {
        Task.init {
            let mempoolStatus = try await getMempoolStatus(showBitcoinLogo: configuration.showBitcoinLogo)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
            completion(Timeline(entries: [mempoolStatus], policy: .after(nextUpdate)))
        }
    }

    func getMempoolStatus(showBitcoinLogo: NSNumber?) async throws -> MempoolStatus {
        let blockHeight = try await mempoolClient.getBlockHeight()
        let recommendedFees = try await mempoolClient.getRecommendedFees()

        return MempoolStatus(
            showBitcoinLogo: Bool(truncating: showBitcoinLogo ?? true),
            blockHeight: blockHeight,
            fastestFee: recommendedFees.fastestFee,
            halfHourFee: recommendedFees.halfHourFee,
            hourFee: recommendedFees.hourFee,
            economyFee: recommendedFees.economyFee,
            minimumFee: recommendedFees.minimumFee
        )
    }

}
