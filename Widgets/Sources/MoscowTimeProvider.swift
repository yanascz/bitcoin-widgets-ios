import WidgetKit

struct MoscowTimeProvider: IntentTimelineProvider {

    private let blockchainClient = BlockchainClient()

    func placeholder(in context: Context) -> MoscowTime {
        return MoscowTime(format: .time, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR")
    }

    func getSnapshot(for configuration: MoscowTimeConfigurationIntent, in context: Context, completion: @escaping (MoscowTime) -> ()) {
        if context.isPreview {
            completion(placeholder(in: context))
            return
        }

        Task.init {
            completion(try await getMoscowTime(for: configuration))
        }
    }

    func getTimeline(for configuration: MoscowTimeConfigurationIntent, in context: Context, completion: @escaping (Timeline<MoscowTime>) -> ()) {
        Task.init {
            let moscowTime = try await getMoscowTime(for: configuration)
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
            completion(Timeline(entries: [moscowTime], policy: .after(nextUpdate)))
        }
    }

    func getMoscowTime(for configuration: MoscowTimeConfigurationIntent) async throws -> MoscowTime {
        let tickers = try await blockchainClient.getTickers()
        let primaryCurrencyCode = "USD"
        let secondaryCurrencyCode = "EUR"

        return MoscowTime(
            format: configuration.format,
            primaryPrice: tickers[primaryCurrencyCode]!.last as NSNumber,
            primaryCurrencyCode: primaryCurrencyCode,
            secondaryPrice: tickers[secondaryCurrencyCode]!.last as NSNumber,
            secondaryCurrencyCode: secondaryCurrencyCode
        )
    }

}
