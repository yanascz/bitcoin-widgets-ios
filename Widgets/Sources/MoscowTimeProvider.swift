import WidgetKit

struct MoscowTimeProvider: TimelineProvider {

    private let blockchainClient = BlockchainClient()

    func placeholder(in context: Context) -> MoscowTime {
        return MoscowTime(primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 60909.31, secondaryCurrencyCode: "EUR")
    }

    func getSnapshot(in context: Context, completion: @escaping (MoscowTime) -> ()) {
        if context.isPreview {
            completion(placeholder(in: context))
            return
        }

        Task.init {
            completion(try await getMoscowTime())
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MoscowTime>) -> ()) {
        Task.init {
            let moscowTime = try await getMoscowTime()
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
            completion(Timeline(entries: [moscowTime], policy: .after(nextUpdate)))
        }
    }

    func getMoscowTime() async throws -> MoscowTime {
        let tickers = try await blockchainClient.getTickers()
        let primaryCurrency = "USD"
        let secondaryCurrency = "EUR"

        return MoscowTime(
            primaryPrice: tickers[primaryCurrency]!.last as NSNumber,
            primaryCurrencyCode: primaryCurrency,
            secondaryPrice: tickers[secondaryCurrency]!.last as NSNumber,
            secondaryCurrencyCode: secondaryCurrency
        )
    }

}
