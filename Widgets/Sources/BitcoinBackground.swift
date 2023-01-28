import SwiftUI
import WidgetKit

struct BitcoinBackground: View {

    let family: WidgetFamily
    let showLogo: Bool

    var body: some View {
        ZStack {
            Color("WidgetBackground")
            if showLogo {
                Image("Bitcoin")
                    .resizable()
                    .opacity(0.07)
                    .aspectRatio(contentMode: family == .systemSmall ? .fit : .fill)
                    .padding(family == .systemSmall ? .all : .trailing)
            }
        }
    }

}
