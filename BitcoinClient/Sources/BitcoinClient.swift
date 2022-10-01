import Foundation
import Network

class BitcoinClient {

    private let urlSession = URLSession.init(configuration: .ephemeral)

    private let host: String
    private let port: Int

    init(host: String, port: Int) {
        self.host = host
        self.port = port
    }

    func getVersionMessage() async throws -> VersionMessage {
        let streamTask = urlSession.streamTask(withHostName: host, port: port)
        streamTask.resume()

        try await streamTask.write(clientVersionMessage)

        guard let headerData = try await streamTask.readData(length: MessageHeader.size) else {
            throw BitcoinClientError.communicationFailure
        }

        let header = MessageHeader(from: headerData)

        guard header.magicNumber == MagicNumber.main.rawValue else {
            throw BitcoinClientError.invalidMagicNumber
        }
        guard header.command == VersionMessage.command else {
            throw BitcoinClientError.protocolViolation
        }

        guard let messageData = try await streamTask.readData(length: Int(header.payloadSize)) else {
            throw BitcoinClientError.communicationFailure
        }
        guard messageData.checksum == header.payloadChecksum else {
            throw BitcoinClientError.protocolViolation
        }

        return VersionMessage(from: messageData)
    }

    private var clientVersionMessage: VersionMessage {
        return VersionMessage(
            protocolVersion: 70001,
            timestamp: Date(),
            nonce: UInt64.random(in: UInt64.min...UInt64.max),
            userAgent: "/BitcoinClient:1.0.0/"
        )
    }

}

enum BitcoinClientError: Error {
    case communicationFailure
    case invalidMagicNumber
    case protocolViolation
}
