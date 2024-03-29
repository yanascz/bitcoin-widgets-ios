import XCTest
import Network

class VersionMessageTests: XCTestCase {

    private let dateFormatter = ISO8601DateFormatter()

    func testInitFromData() throws {
        let data = Data([
            // protocolVersion
            0x80, 0x11, 0x01, 0x00,
            // services
            0x0D, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            // timestamp
            0x73, 0x59, 0xA7, 0x62, 0x00, 0x00, 0x00, 0x00,
            // recipient
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00,
            // sender
            0x0D, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x20, 0x8D,
            // nonce
            0x13, 0x57, 0xB4, 0x3A, 0x2C, 0x20, 0x9D, 0xDD,
            // userAgent
            0x10, 0x2F, 0x53, 0x61, 0x74, 0x6F, 0x73, 0x68, 0x69, 0x3A, 0x32, 0x33, 0x2E, 0x30, 0x2E, 0x30, 0x2F,
            // blockHeight
            0xF5, 0x4C, 0x0B, 0x00,
            // relayTxs
            0x01
        ])

        let message = VersionMessage(from: data)

        XCTAssertEqual(message.protocolVersion, 70016)
        XCTAssertEqual(message.services, 1037)
        XCTAssertEqual(message.timestamp, dateFormatter.date(from: "2022-06-13T15:36:19Z"))
        XCTAssertEqual(message.recipient.services, 0)
        XCTAssertEqual(message.recipient.address, IPv6Address.any)
        XCTAssertEqual(message.recipient.port, 0)
        XCTAssertEqual(message.sender.services, 1037)
        XCTAssertEqual(message.sender.address, IPv6Address.any)
        XCTAssertEqual(message.sender.port, 8333)
        XCTAssertEqual(message.nonce, 0xDD9D202C3AB45713)
        XCTAssertEqual(message.userAgent, "/Satoshi:23.0.0/")
        XCTAssertEqual(message.blockHeight, 740597)
        XCTAssertTrue(message.relayTxs)
    }

    func testToData() throws {
        let message = VersionMessage(
            protocolVersion: 70001,
            timestamp: dateFormatter.date(from: "2022-06-13T15:36:19Z")!,
            nonce: 0xDD9D202C3AB45713,
            userAgent: "/Satoshi:22.0.0/"
        )

        XCTAssertEqual(message.data, Data([
            // protocolVersion
            0x71, 0x11, 0x01, 0x00,
            // services
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            // timestamp
            0x73, 0x59, 0xA7, 0x62, 0x00, 0x00, 0x00, 0x00,
            // recipient
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00,
            // sender
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00,
            // nonce
            0x13, 0x57, 0xB4, 0x3A, 0x2C, 0x20, 0x9D, 0xDD,
            // userAgent
            0x10, 0x2F, 0x53, 0x61, 0x74, 0x6F, 0x73, 0x68, 0x69, 0x3A, 0x32, 0x32, 0x2E, 0x30, 0x2E, 0x30, 0x2F,
            // blockHeight
            0x00, 0x00, 0x00, 0x00,
            // relayTxs
            0x00
        ]))
    }

}
