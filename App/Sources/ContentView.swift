import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add to").font(.title2)) {
                    if #available(iOS 16.0, *) {
                        lockScreenNavigationLink
                    }
                    homeScreenNavigationLink
                    todayViewNavigationLink
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
            }.navigationTitle("Bitcoin Widgets").listStyle(.plain)
        }
    }

    @State private var lockScreenNavigationLinkOpened: Bool = false
    @State private var homeScreenNavigationLinkOpened: Bool = false
    @State private var todayViewNavigationLinkOpened: Bool = false

    @available(iOS 16.0, *)
    private var lockScreenNavigationLink: some View {
        // FYI: This constructor will be deprecated in iOS 16
        // see https://developer.apple.com/documentation/swiftui/migrating-to-new-navigation-types

        NavigationLink(destination:
            List {
                Label("Touch and hold the Lock Screen until the Customize button appears at the bottom of the screen.", systemImage: "1.circle.fill")
                Label("Tap the Customize button, then tap the box above or below the time.", systemImage: "2.circle.fill")
                Label("Look up Bitcoin Widgets, then tap or drag the widgets you want to add.", systemImage: "3.circle.fill")
                Label("Close the widget popup, then tap Done.", systemImage: "4.circle.fill")
            }
            .navigationTitle("Add to Lock Screen")
            .listStyle(.plain)
            .customBack {
                lockScreenNavigationLinkOpened = false
            },
            isActive: $lockScreenNavigationLinkOpened,
            label: {
                Label("Lock Screen", systemImage: "plus.circle.fill")
            })
    }

    private var homeScreenNavigationLink: some View {
        NavigationLink(destination:
            List {
                Label("From the Home Screen, touch and hold a widget or an empty area until the apps jiggle.", systemImage: "1.circle.fill")
                Label("Tap the Add button in the upper-left corner.", systemImage: "2.circle.fill")
                Label("Look up Bitcoin Widgets, then choose desired widget and size.", systemImage: "3.circle.fill")
                Label("Tap Add Widget, then tap Done.", systemImage: "4.circle.fill")
            }
            .navigationTitle("Add to Home Screen")
            .listStyle(.plain)
            .customBack {
                homeScreenNavigationLinkOpened = false
            },
            isActive: $homeScreenNavigationLinkOpened,
            label: {
                Label("Home Screen", systemImage: "plus.circle.fill")
            })
    }

    private var todayViewNavigationLink: some View {
        NavigationLink(destination:
            List {
                Label("From the Home Screen, swipe right to access the Today View.", systemImage: "1.circle.fill")
                Label("Scroll down and tap the Edit button, then tap the Add button in the upper-left corner.", systemImage: "2.circle.fill")
                Label("Look up Bitcoin Widgets, then choose desired widget and size.", systemImage: "3.circle.fill")
                Label("Tap Add Widget, then tap Done.", systemImage: "4.circle.fill")
            }
            .navigationTitle("Add to Today View")
            .listStyle(.plain)
            .customBack {
                todayViewNavigationLinkOpened = false
            },
            isActive: $todayViewNavigationLinkOpened,
            label: {
                Label("Today View", systemImage: "plus.circle.fill")
            })
    }
}

struct CustomBack: ViewModifier {
    let callback: () -> Void

    init(_ callback: @escaping () -> Void) {
        self.callback = callback
    }

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    callback()
                }, label: {
                    HStack {
                        Image(systemName: "house")
                        Text("go home")
                    }
                })
            )
    }
}

extension View {
    public func customBack(_ callback: @escaping () -> Void) -> some View {
        modifier(CustomBack(callback))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
