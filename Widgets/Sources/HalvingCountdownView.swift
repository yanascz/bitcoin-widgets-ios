import WidgetKit
import SwiftUI

struct HalvingCountdownView: View {

    @Environment(\.widgetFamily) var family: WidgetFamily
    var halvingCountdown: HalvingCountdownProvider.Entry

    var body: some View {
#if os(watchOS)
        accessoryView(for: family)
#else
        if #available(iOSApplicationExtension 17.0, *) {
            if family == .accessoryRectangular || family == .accessoryInline {
                accessoryView(for: family).containerBackground(for: .widget) {}
            } else {
                systemView(for: family).containerBackground(for: .widget) {
                    BitcoinBackground(family: family, showLogo: halvingCountdown.showBitcoinLogo)
                }
            }
        } else if #available(iOSApplicationExtension 16.0, *), family == .accessoryRectangular || family == .accessoryInline {
            accessoryView(for: family)
        } else {
            ZStack {
                BitcoinBackground(family: family, showLogo: halvingCountdown.showBitcoinLogo)
                systemView(for: family).padding()
            }
        }
#endif
    }

    @available(iOSApplicationExtension 16.0, *)
    func accessoryView(for family: WidgetFamily) -> some View {
        VStack(alignment: .trailing) {
            Text(halvingCountdown.blockCount, formatter: numberFormatter())
                .font(.system(size: 37))
            Text(halvingCountdown.estimate, formatter: dateFormatter())
                .font(.footnote)
                .padding(.trailing, 2)
        }
    }

#if !os(watchOS)
    func systemView(for family: WidgetFamily) -> some View {
        VStack(alignment: family == .systemSmall ? .trailing : .center) {
            Text(halvingCountdown.blockCount, formatter: numberFormatter())
                .font(family == .systemSmall ? .title : .largeTitle)
                .foregroundColor(.yellow)
                .padding(.bottom, 1)
            VStack(alignment: .trailing) {
                Text(halvingCountdown.estimate, formatter: dateFormatter())
                    .foregroundColor(.white)
                Text(verbatim: etaFormatter().string(from: Date(), to: halvingCountdown.estimate)!)
                    .foregroundColor(.gray)
            }.font(family == .systemSmall ? .footnote : .body)
                .padding(.trailing, family == .systemSmall ? 2 : 0)
        }
    }
#endif

    private func numberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0

        return formatter
    }

    private func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short

        return formatter
    }

    private func etaFormatter() -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
        formatter.maximumUnitCount = 3

        return formatter
    }

}

struct HalvingCountdownView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
#if !os(watchOS)
            HalvingCountdownView(halvingCountdown: HalvingCountdown(showBitcoinLogo: true, blockCount: 13842, estimate: Date(timeIntervalSince1970: 1713954060)))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            HalvingCountdownView(halvingCountdown: HalvingCountdown(showBitcoinLogo: false, blockCount: 13842, estimate: Date(timeIntervalSince1970: 1713954060)))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
#endif

            if #available(iOSApplicationExtension 16.0, *) {
                HalvingCountdownView(halvingCountdown: HalvingCountdown(showBitcoinLogo: true, blockCount: 13842, estimate: Date(timeIntervalSince1970: 1713954060)))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            }
        }
    }

}
