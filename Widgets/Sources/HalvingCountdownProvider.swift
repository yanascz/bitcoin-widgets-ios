import WidgetKit

struct HalvingCountdownProvider: IntentTimelineProvider {

    private static let blocksPerEpoch: Int32 = 210000

    private let mempoolClient = MempoolClient()

    @available(iOSApplicationExtension 16.0, watchOS 9.0, *)
    func recommendations() -> [IntentRecommendation<MempoolConfigurationIntent>] {
        return [IntentRecommendation(intent: MempoolConfigurationIntent(), description: "HalvingCountdownWidget.displayName")]
    }

    func placeholder(in context: Context) -> HalvingCountdown {
        return HalvingCountdown(showBitcoinLogo: true, blockCount: 13842, estimate: Date(timeIntervalSince1970: 1713954060))
    }

    func getSnapshot(for configuration: MempoolConfigurationIntent, in context: Context, completion: @escaping (HalvingCountdown) -> ()) {
        if context.isPreview {
            completion(placeholder(in: context))
            return
        }

        Task.init {
            completion(try await getHalvingCountdown(showBitcoinLogo: configuration.showBitcoinLogo))
        }
    }

    func getTimeline(for configuration: MempoolConfigurationIntent, in context: Context, completion: @escaping (Timeline<HalvingCountdown>) -> ()) {
        Task.init {
            let halvingCountdown = try await getHalvingCountdown(showBitcoinLogo: configuration.showBitcoinLogo)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
            completion(Timeline(entries: [halvingCountdown], policy: .after(nextUpdate)))
        }
    }

    func getHalvingCountdown(showBitcoinLogo: NSNumber?) async throws -> HalvingCountdown {
        let blockHeight = try await mempoolClient.getBlockHeight()
        let blockCount = Self.blocksPerEpoch - blockHeight % Self.blocksPerEpoch

        let secondsPerThreeWeeks = TimeInterval(21 * 24 * 60 * 60)
        let threeWeeksAgo = Date(timeIntervalSinceNow: -secondsPerThreeWeeks)
        let blockHeightThreeWeeksAgo = try await mempoolClient.getBlockHeightByDate(threeWeeksAgo)
        let secondsPerBlock = secondsPerThreeWeeks / Double(blockHeight - blockHeightThreeWeeksAgo + 1)

        return HalvingCountdown(
            showBitcoinLogo: Bool(truncating: showBitcoinLogo ?? true),
            blockCount: NSNumber(value: blockCount),
            estimate: Date(timeIntervalSinceNow: Double(blockCount) * secondsPerBlock)
        )
    }

}

