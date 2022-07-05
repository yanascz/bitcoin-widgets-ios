import Foundation

struct VersionMessage {

    static let command: String = "version"

    let protocolVersion: Int32
    let services: UInt64
    let timestamp: Date
    let recipient: NetworkAddress
    let sender: NetworkAddress
    let nonce: UInt64
    let userAgent: String
    let blockHeight: Int32
    let relayTxs: Bool

    init(protocolVersion: Int32, timestamp: Date, nonce: UInt64, userAgent: String) {
        self.protocolVersion = protocolVersion
        self.services = 0
        self.timestamp = timestamp
        self.recipient = NetworkAddress()
        self.sender = NetworkAddress()
        self.nonce = nonce
        self.userAgent = userAgent
        self.blockHeight = 0
        self.relayTxs = false
    }

    init(from data: Data) {
        let input = InputStream(data: data)
        input.open(); defer { input.close() }

        self.protocolVersion = input.readInt32()
        self.services = input.readUInt64()
        self.timestamp = Date(timeIntervalSince1970: TimeInterval(input.readInt64()))
        self.recipient = NetworkAddress(from: input)
        self.sender = NetworkAddress(from: input)
        self.nonce = input.readUInt64()
        self.userAgent = input.readString()
        self.blockHeight = input.readInt32()
        self.relayTxs = input.readBool()
    }

    var data: Data {
        var data = Data()
        data.append(protocolVersion)
        data.append(services)
        data.append(Int64(timestamp.timeIntervalSince1970))
        data.append(recipient.data)
        data.append(sender.data)
        data.append(nonce)
        data.append(userAgent)
        data.append(blockHeight)
        data.append(relayTxs)

        return data
    }

}
