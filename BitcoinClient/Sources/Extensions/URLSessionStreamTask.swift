import Foundation

extension URLSessionStreamTask {

    private static let defaultTimeout: Double = 1

    func readData(length: Int) async throws -> Data? {
        return try await readData(ofMinLength: length, maxLength: length, timeout: Self.defaultTimeout).0
    }

    func write(_ message: VersionMessage) async throws {
        let messageData = message.data
        let header = MessageHeader(
            command: VersionMessage.command,
            payloadSize: UInt32(messageData.count),
            payloadChecksum: messageData.checksum
        )

        try await write(header.data + messageData, timeout: Self.defaultTimeout)
    }

}
