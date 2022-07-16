import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            HStack {
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .frame(width: 29, height: 29)
                Text("Bitcoin Widgets")
                    .font(.title)
            }.padding()
            List {
                Section(header: Text("Add to Today View").font(.title2)) {
                    Label("From the Home Screen, swipe right to access the Today View.", systemImage: "1.circle.fill")
                    Label("Scroll down and tap the Edit button, then tap the Add button in the upper-left corner.", systemImage: "2.circle.fill")
                    Label("Look up Bitcoin Widgets, then choose desired widget and size.", systemImage: "3.circle.fill")
                    Label("Tap Add Widget, then tap Done.", systemImage: "4.circle.fill")
                }
                Section(header: Text("Add to Home Screen").font(.title2)) {
                    Label("From the Home Screen, touch and hold a widget or an empty area until the apps jiggle.", systemImage: "1.circle.fill")
                    Label("Tap the Add button in the upper-left corner.", systemImage: "2.circle.fill")
                    Label("Look up Bitcoin Widgets, then choose desired widget and size.", systemImage: "3.circle.fill")
                    Label("Tap Add Widget, then tap Done.", systemImage: "4.circle.fill")
                }
                Section(header: Text("Configure").font(.title2)) {
                    Label("Touch and hold a widget until menu appears, then tap Edit Widget.", systemImage: "1.circle.fill")
                    Label("Provide required properties, then tap anywhere when done.", systemImage: "2.circle.fill")
                }
                Section(header: Text("Find out more").font(.title2)) {
                    LabelLink("Source code", url: "https://github.com/yanascz/bitcoin-widgets-ios", systemImage: "chevron.left.forwardslash.chevron.right")
                    LabelLink("Issue tracking", url: "https://github.com/yanascz/bitcoin-widgets-ios/issues",
                        systemImage: "ladybug.fill")
                }
                Section(header: Text("Support").font(.title2)) {
                    LabelLink("widgets@ln.yanas.cz", url: "lightning:widgets@ln.yanas.cz",
                        systemImage: "bolt.fill")
                }
            }.listStyle(.plain)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
