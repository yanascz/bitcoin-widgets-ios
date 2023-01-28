import WidgetKit
import SwiftUI
import Intents

struct MempoolStatusView: View {

    @Environment(\.widgetFamily) var family: WidgetFamily
    var mempoolStatus: MempoolStatusProvider.Entry

    var body: some View {
        if #available(iOSApplicationExtension 16.0, *), family == .accessoryRectangular || family == .accessoryInline {
            accessoryView(for: family)
        } else {
            ZStack {
                BitcoinBackground(family: family, showLogo: mempoolStatus.showBitcoinLogo)
                systemView(for: family)
            }
        }
    }

    @available(iOSApplicationExtension 16.0, *)
    func accessoryView(for family: WidgetFamily) -> some View {
        VStack(alignment: .trailing) {
            if family == .accessoryInline {
                Label(String(mempoolStatus.blockHeight), systemImage: "bitcoinsign.square.fill")
            } else {
                Text(String(mempoolStatus.blockHeight))
                    .font(.system(size: 37))
                HStack {
                    Text(String(mempoolStatus.economyFee))
                    Text("/")
                        .foregroundColor(.secondary)
                    Text(String(mempoolStatus.hourFee))
                    Text("/")
                        .foregroundColor(.secondary)
                    Text(String(mempoolStatus.halfHourFee))
                    Text("/")
                        .foregroundColor(.secondary)
                    Text(String(mempoolStatus.fastestFee))
                }.font(.footnote).padding(.trailing, 2)
            }
        }
    }

    func systemView(for family: WidgetFamily) -> some View {
        VStack(alignment: family == .systemSmall ? .trailing : .center) {
            Text(String(mempoolStatus.blockHeight))
                .font(family == .systemSmall ? .title : .largeTitle)
                .foregroundColor(Color("MempoolColor"))
                .padding(.bottom, 1)
            VStack(alignment: .trailing) {
                HStack {
                    Text(String(mempoolStatus.economyFee))
                        .foregroundColor(.white)
                    Text("/")
                        .foregroundColor(.gray)
                    Text(String(mempoolStatus.hourFee))
                        .foregroundColor(.white)
                    Text("/")
                        .foregroundColor(.gray)
                    Text(String(mempoolStatus.halfHourFee))
                        .foregroundColor(.white)
                    Text("/")
                        .foregroundColor(.gray)
                    Text(String(mempoolStatus.fastestFee))
                        .foregroundColor(.white)
                }
                HStack {
                    Text("MempoolStatusView.minimumFee")
                        .foregroundColor(.gray)
                    Text(String(mempoolStatus.minimumFee))
                        .foregroundColor(.white)
                }
            }.font(family == .systemSmall ? .footnote : .body)
                .padding(.trailing, family == .systemSmall ? 2 : 0)
        }.padding()
    }

}

struct MempoolStatusView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: true, blockHeight: 755237, fastestFee: 17, halfHourFee: 8, hourFee: 3, economyFee: 1, minimumFee: 1))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: true, blockHeight: 755237, fastestFee: 1, halfHourFee: 1, hourFee: 1, economyFee: 1, minimumFee: 1))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            MempoolStatusView(mempoolStatus: MempoolStatus(showBitcoinLogo: false, blockHeight: 755237, fastestFee: 2791, halfHourFee: 730, hourFee: 130, economyFee: 37, minimumFee: 19))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

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
