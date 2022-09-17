import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            HStack {
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .frame(width: 29, height: 29)
                Text("ContentView.title")
                    .font(.title)
            }.padding()
            List {
                Section(header: Text("ContentView.AddToTodayView.header").font(.title2)) {
                    Label("ContentView.AddToTodayView.step1", systemImage: "1.circle.fill")
                    Label("ContentView.AddToTodayView.step2", systemImage: "2.circle.fill")
                    Label("ContentView.AddToTodayView.step3", systemImage: "3.circle.fill")
                    Label("ContentView.AddToTodayView.step4", systemImage: "4.circle.fill")
                }
                Section(header: Text("ContentView.AddToHomeScreen.header").font(.title2)) {
                    Label("ContentView.AddToHomeScreen.step1", systemImage: "1.circle.fill")
                    Label("ContentView.AddToHomeScreen.step2", systemImage: "2.circle.fill")
                    Label("ContentView.AddToHomeScreen.step3", systemImage: "3.circle.fill")
                    Label("ContentView.AddToHomeScreen.step4", systemImage: "4.circle.fill")
                }
                if #available(iOSApplicationExtension 16.0, *) {
                    Section(header: Text("ContentView.AddToLockScreen.header").font(.title2)) {
                        Label("ContentView.AddToLockScreen.step1", systemImage: "1.circle.fill")
                        Label("ContentView.AddToLockScreen.step2", systemImage: "2.circle.fill")
                        Label("ContentView.AddToLockScreen.step3", systemImage: "3.circle.fill")
                        Label("ContentView.AddToLockScreen.step4", systemImage: "4.circle.fill")
                    }
                }
                Section(header: Text("ContentView.Configure.header").font(.title2)) {
                    Label("ContentView.Configure.step1", systemImage: "1.circle.fill")
                    Label("ContentView.Configure.step2", systemImage: "2.circle.fill")
                }
                Section(header: Text("ContentView.FindOutMore.header").font(.title2)) {
                    LabelLink("ContentView.FindOutMore.sourceCode", url: "https://github.com/yanascz/bitcoin-widgets-ios",
                        systemImage: "chevron.left.forwardslash.chevron.right")
                    LabelLink("ContentView.FindOutMore.issueTracking", url: "https://github.com/yanascz/bitcoin-widgets-ios/issues",
                        systemImage: "ladybug.fill")
                }
                Section(header: Text("ContentView.Support.header").font(.title2)) {
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
