import Foundation

struct MessageHeader {

    static let size = 24
    private static let commandSize = 12

    let magicNumber: UInt32
    let command: String
    let payloadSize: UInt32
    let payloadChecksum: UInt32

    init(command: String, payloadSize: UInt32, payloadChecksum: UInt32) {
        self.magicNumber = MagicNumber.main.rawValue
        self.command = command
        self.payloadSize = payloadSize
        self.payloadChecksum = payloadChecksum
    }

    init(from data: Data) {
        let input = InputStream(data: data)
        input.open(); defer { input.close() }

        self.magicNumber = input.readUInt32()
        self.command = String(bytes: input.readData(count: Self.commandSize).filter { $0 > 0 }, encoding: .ascii)!
        self.payloadSize = input.readUInt32()
        self.payloadChecksum = input.readUInt32()
    }

    var data: Data {
        var data = Data()
        data.append(magicNumber)
        data.append(command.data(using: .ascii)!)
        data.append(Data(count: Self.commandSize - command.count))
        data.append(payloadSize)
        data.append(payloadChecksum)

        return data
    }

}
