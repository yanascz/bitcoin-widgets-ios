import WidgetKit
import SwiftUI
import Intents

struct MempoolStatusView: View {

    @Environment(\.widgetFamily) var family: WidgetFamily
    var mempoolStatus: MempoolStatusProvider.Entry

    var body: some View {
        ZStack {
            Color("WidgetBackground")
            Image("Bitcoin")
                .resizable()
                .opacity(0.07)
                .aspectRatio(contentMode: family == .systemSmall ? .fit : .fill)
                .padding(family == .systemSmall ? .all : .trailing)
            content(for: family)
        }
    }

    func content(for family: WidgetFamily) -> some View {
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
            MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 740597, fastestFee: 7, halfHourFee: 3, hourFee: 1, minimumFee: 1))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 740597, fastestFee: 1, halfHourFee: 1, hourFee: 1, minimumFee: 1))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            MempoolStatusView(mempoolStatus: MempoolStatus(blockHeight: 740597, fastestFee: 2791, halfHourFee: 730, hourFee: 130, minimumFee: 19))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }

}
