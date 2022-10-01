import SwiftUI
import WidgetKit

struct BitcoinBackground: View {

    let family: WidgetFamily

    var body: some View {
        ZStack {
            Color("WidgetBackground")
            Image("Bitcoin")
                .resizable()
                .opacity(0.07)
                .aspectRatio(contentMode: family == .systemSmall ? .fit : .fill)
                .padding(family == .systemSmall ? .all : .trailing)
        }
    }

}
