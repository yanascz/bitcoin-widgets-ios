import WidgetKit

struct MoscowTime: TimelineEntry {

    let date: Date = Date()
    let showBitcoinLogo: Bool
    let format: MoscowTimeFormat
    let primaryPrice: NSNumber
    let primaryCurrencyCode: String
    let secondaryPrice: NSNumber
    let secondaryCurrencyCode: String

}
