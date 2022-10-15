import SwiftUI

struct ContentView: View {

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { content }
        } else {
            NavigationView { content }
        }
    }

    private var content: some View {
        List {
            Section(header: Text("ContentView.AddTo.header").font(.title2)) {
                if #available(iOS 16.0, *) {
                    lockScreenSteps
                }
                homeScreenSteps
                todayViewSteps
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
                LabelLink("widgets@yanas.cz", url: "lightning:widgets@yanas.cz", systemImage: "bolt.fill")
            }
        }.navigationTitle("ContentView.title").listStyle(.plain)
    }

    @available(iOS 16.0, *)
    private var lockScreenSteps: some View {
        NavigationLink {
            List {
                Label("ContentView.AddTo.LockScreen.step1", systemImage: "1.circle.fill")
                Label("ContentView.AddTo.LockScreen.step2", systemImage: "2.circle.fill")
                Label("ContentView.AddTo.LockScreen.step3", systemImage: "3.circle.fill")
                Label("ContentView.AddTo.LockScreen.step4", systemImage: "4.circle.fill")
            }.navigationTitle("ContentView.AddTo.LockScreen.header").listStyle(.plain)
        } label: {
            Label("ContentView.AddTo.LockScreen.link", systemImage: "plus.circle.fill")
        }
    }

    private var homeScreenSteps: some View {
        NavigationLink {
            List {
                Label("ContentView.AddTo.HomeScreen.step1", systemImage: "1.circle.fill")
                Label("ContentView.AddTo.HomeScreen.step2", systemImage: "2.circle.fill")
                Label("ContentView.AddTo.HomeScreen.step3", systemImage: "3.circle.fill")
                Label("ContentView.AddTo.HomeScreen.step4", systemImage: "4.circle.fill")
            }.navigationTitle("ContentView.AddTo.HomeScreen.header").listStyle(.plain)
        } label: {
            Label("ContentView.AddTo.HomeScreen.link", systemImage: "plus.circle.fill")
        }
    }

    private var todayViewSteps: some View {
        NavigationLink {
            List {
                Label("ContentView.AddTo.TodayView.step1", systemImage: "1.circle.fill")
                Label("ContentView.AddTo.TodayView.step2", systemImage: "2.circle.fill")
                Label("ContentView.AddTo.TodayView.step3", systemImage: "3.circle.fill")
                Label("ContentView.AddTo.TodayView.step4", systemImage: "4.circle.fill")
            }.navigationTitle("ContentView.AddTo.TodayView.header").listStyle(.plain)
        } label: {
            Label("ContentView.AddTo.TodayView.link", systemImage: "plus.circle.fill")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
