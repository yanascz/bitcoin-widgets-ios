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
                Color("WidgetBackground")
                Image("Bitcoin")
                    .resizable()
                    .opacity(0.07)
                    .aspectRatio(contentMode: family == .systemSmall ? .fit : .fill)
                    .padding(family == .systemSmall ? .all : .trailing)
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
                    Text(String(mempoolStatus.minimumFee))
                        .font(.footnote)
                    Text("/")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Text(String(mempoolStatus.hourFee))
                        .font(.footnote)
                    Text("/")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Text(String(mempoolStatus.halfHourFee))
                        .font(.footnote)
                    Text("/")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Text(String(mempoolStatus.fastestFee))
                        .font(.footnote)
                }.padding(.trailing, 2)
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
                    Text(String(mempoolStatus.hourFee))
                        .font(.footnote)
                        .foregroundColor(.white)
                    Text("/")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text(String(mempoolStatus.halfHourFee))
                        .font(.footnote)
                        .foregroundColor(.white)
                    Text("/")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text(String(mempoolStatus.fastestFee))
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                HStack {
                    Text("minimum")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text(String(mempoolStatus.minimumFee))
                        .font(.footnote)
                        .foregroundColor(.white)
                }
            }.padding(.trailing, family == .systemSmall ? 2 : 0)
        }.padding()
    }

}

struct MempoolStatusView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 754091, fastestFee: 7, halfHourFee: 3, hourFee: 1, minimumFee: 1))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 754091, fastestFee: 1, halfHourFee: 1, hourFee: 1, minimumFee: 1))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 754091, fastestFee: 2791, halfHourFee: 730, hourFee: 130, minimumFee: 19))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            if #available(iOSApplicationExtension 16.0, *) {
                MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 754091, fastestFee: 1, halfHourFee: 1, hourFee: 1, minimumFee: 1))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 754091, fastestFee: 7, halfHourFee: 3, hourFee: 1, minimumFee: 1))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 754091, fastestFee: 2791, halfHourFee: 730, hourFee: 130, minimumFee: 19))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))

                MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 754091, fastestFee: 2791, halfHourFee: 730, hourFee: 130, minimumFee: 19))
                    .previewContext(WidgetPreviewContext(family: .accessoryInline))
            }
        }
    }

}
