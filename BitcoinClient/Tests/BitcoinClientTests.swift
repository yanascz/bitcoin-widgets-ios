import XCTest

class BitcoinClientTests: XCTestCase {

    func testGetVersion() async throws {
        let client = BitcoinClient(host: "127.0.0.1", port: 8333)
        let message = try await client.getVersionMessage()

        XCTAssertEqual(message.protocolVersion, 70016)
        XCTAssertEqual(message.services, 1033)
        XCTAssertGreaterThanOrEqual(message.timestamp, Date.now.advanced(by: -21))
        XCTAssertLessThanOrEqual(message.timestamp, Date.now.advanced(by: 21))
        XCTAssertNotNil(message.recipient)
        XCTAssertNotNil(message.sender)
        XCTAssertNotNil(message.nonce)
        XCTAssertEqual(message.userAgent, "/Satoshi:23.0.0/")
        XCTAssertGreaterThanOrEqual(message.blockHeight, 740597)
        XCTAssertTrue(message.relayTxs)
    }

}
