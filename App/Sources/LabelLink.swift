import SwiftUI

struct LabelLink: View {

    let titleKey: LocalizedStringKey
    let destination: URL
    let systemImage: String

    init (_ titleKey: LocalizedStringKey, url: String, systemImage: String) {
        self.titleKey = titleKey
        self.destination = URL(string: url)!
        self.systemImage = systemImage
    }

    var body: some View {
        Label {
            HStack {
                Link(titleKey, destination: destination)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image(systemName: systemImage)
        }
    }

}
