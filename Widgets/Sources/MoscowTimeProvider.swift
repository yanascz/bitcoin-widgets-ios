import WidgetKit

struct MoscowTimeProvider: IntentTimelineProvider {

    private let blockchainClient = BlockchainClient()

    @available(iOSApplicationExtension 16.0, watchOS 9.0, *)
    func recommendations() -> [IntentRecommendation<MoscowTimeConfigurationIntent>] {
        let configuration = MoscowTimeConfigurationIntent()
        configuration.format = .time
        configuration.primaryCurrency = .usd
        configuration.secondaryCurrency = .eur

        return [IntentRecommendation(intent: configuration, description: "MoscowTimeWidget.displayName")]
    }

    func placeholder(in context: Context) -> MoscowTime {
        return MoscowTime(showBitcoinLogo: true, format: .time, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR")
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
        let primaryCurrencyCode = configuration.primaryCurrency.code
        let secondaryCurrencyCode = configuration.secondaryCurrency.code

        return MoscowTime(
            showBitcoinLogo: Bool(truncating: configuration.showBitcoinLogo ?? true),
            format: configuration.format,
            primaryPrice: NSNumber(value: tickers[primaryCurrencyCode]!.last),
            primaryCurrencyCode: primaryCurrencyCode,
            secondaryPrice: NSNumber(value: tickers[secondaryCurrencyCode]!.last),
            secondaryCurrencyCode: secondaryCurrencyCode
        )
    }

}

extension FiatCurrency {

    var code: String {
        switch self {
            case .cad:
                return "CAD"
            case .chf:
                return "CHF"
            case .eur:
                return "EUR"
            case .gbp:
                return "GBP"
            case .usd:
                return "USD"
            default:
                return "?"
        }
    }

}
