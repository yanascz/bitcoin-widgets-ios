import SwiftUI

struct LabelLink: View {

    let title: String
    let destination: URL
    let systemImage: String

    init (_ title: String, url: String, systemImage: String) {
        self.title = title
        self.destination = URL(string: url)!
        self.systemImage = systemImage
    }

    var body: some View {
        Label {
            HStack {
                Link(title, destination: destination)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image(systemName: systemImage)
        }
    }

}
