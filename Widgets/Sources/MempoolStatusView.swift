import WidgetKit
import SwiftUI
import Intents

struct MempoolStatusView: View {

    private static let feeSeparator: String = " / "

    @Environment(\.widgetFamily) var family: WidgetFamily
    var mempoolStatus: MempoolStatusProvider.Entry

    var body: some View {
#if os(watchOS)
        accessoryView(for: family)
#else
        if #available(iOSApplicationExtension 17.0, *) {
            if family == .accessoryRectangular || family == .accessoryInline {
                accessoryView(for: family).containerBackground(for: .widget) {}
            } else {
                systemView(for: family).containerBackground(for: .widget) {
                    BitcoinBackground(family: family, showLogo: mempoolStatus.showBitcoinLogo)
                }
            }
        } else if #available(iOSApplicationExtension 16.0, *), family == .accessoryRectangular || family == .accessoryInline {
            accessoryView(for: family)
        } else {
            ZStack {
                BitcoinBackground(family: family, showLogo: mempoolStatus.showBitcoinLogo)
                systemView(for: family).padding()
            }
        }
#endif
    }

    @available(iOSApplicationExtension 16.0, *)
    func accessoryView(for family: WidgetFamily) -> some View {
        VStack(alignment: .trailing) {
            if family == .accessoryInline {
                Label(String(mempoolStatus.blockHeight), systemImage: "bitcoinsign.square.fill")
            } else {
                Text(verbatim: String(mempoolStatus.blockHeight))
                    .font(.system(size: 37))
                VStack {
                    Text(verbatim: String(mempoolStatus.economyFee))
                    + Text(verbatim: Self.feeSeparator).foregroundColor(.secondary)
                    + Text(verbatim: String(mempoolStatus.hourFee))
                    + Text(verbatim: Self.feeSeparator).foregroundColor(.secondary)
                    + Text(verbatim: String(mempoolStatus.halfHourFee))
                    + Text(verbatim: Self.feeSeparator).foregroundColor(.secondary)
                    + Text(verbatim: String(mempoolStatus.fastestFee))
                }.font(.footnote).padding(.trailing, 2)
            }
        }
    }

#if !os(watchOS)
    func systemView(for family: WidgetFamily) -> some View {
        VStack(alignment: family == .systemSmall ? .trailing : .center) {
            Text(verbatim: String(mempoolStatus.blockHeight))
                .font(family == .systemSmall ? .title : .largeTitle)
                .foregroundColor(Color("MempoolColor"))
                .padding(.bottom, 1)
            VStack(alignment: .trailing) {
                Text(verbatim: String(mempoolStatus.economyFee)).foregroundColor(.white)
                + Text(verbatim: Self.feeSeparator).foregroundColor(.gray)
                + Text(verbatim: String(mempoolStatus.hourFee)).foregroundColor(.white)
                + Text(verbatim: Self.feeSeparator).foregroundColor(.gray)
                + Text(verbatim: String(mempoolStatus.halfHourFee)).foregroundColor(.white)
                + Text(verbatim: Self.feeSeparator).foregroundColor(.gray)
                + Text(verbatim: String(mempoolStatus.fastestFee)).foregroundColor(.white)
                Text("MempoolStatusView.minimumFee").foregroundColor(.gray)
                + Text(verbatim: " ")
                + Text(verbatim: String(mempoolStatus.minimumFee)).foregroundColor(.white)
            }.font(family == .systemSmall ? .footnote : .body)
                .padding(.trailing, family == .systemSmall ? 2 : 0)
                .multilineTextAlignment(.trailing)
        }
    }
#endif
}

struct MempoolStatusView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
#if !os(watchOS)
            MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: true, blockHeight: 755237, fastestFee: 17, halfHourFee: 8, hourFee: 3, economyFee: 1, minimumFee: 1))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: false, blockHeight: 755237, fastestFee: 2791, halfHourFee: 730, hourFee: 130, economyFee: 37, minimumFee: 19))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: true, blockHeight: 755237, fastestFee: 1, halfHourFee: 1, hourFee: 1, economyFee: 1, minimumFee: 1))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: false, blockHeight: 755237, fastestFee: 2791, halfHourFee: 730, hourFee: 130, economyFee: 37, minimumFee: 19))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
#endif

            if #available(iOSApplicationExtension 16.0, *) {
                MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: true, blockHeight: 755237, fastestFee: 1, halfHourFee: 1, hourFee: 1, economyFee: 1, minimumFee: 1))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: false, blockHeight: 755237, fastestFee: 17, halfHourFee: 8, hourFee: 3, economyFee: 1, minimumFee: 1))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: true, blockHeight: 755237, fastestFee: 2791, halfHourFee: 730, hourFee: 130, economyFee: 37, minimumFee: 19))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))

                MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: true, blockHeight: 755237, fastestFee: 2791, halfHourFee: 730, hourFee: 130, economyFee: 37, minimumFee: 19))
                    .previewContext(WidgetPreviewContext(family: .accessoryInline))
            }
        }
    }

}
