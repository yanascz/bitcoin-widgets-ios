import Foundation
import Network

struct NetworkAddress {

    private static let addressSize = 16

    let services: UInt64
    let address: IPv6Address
    let port: UInt16

    init() {
        self.services = 0
        self.address = IPv6Address.any
        self.port = 0
    }

    init(from input: InputStream) {
        self.services = input.readUInt64()
        self.address = IPv6Address(input.readData(count: Self.addressSize))!
        self.port = input.readUInt16()
    }

    var data: Data {
        var data = Data()
        data.append(services)
        data.append(address.rawValue)
        data.append(port)

        return data
    }

}
