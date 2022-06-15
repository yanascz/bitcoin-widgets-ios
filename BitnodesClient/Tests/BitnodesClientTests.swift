import XCTest

class BitnodesClientTests: XCTestCase {

    private let host = "todo.onion"
    private let port = 8333

    func testCheckNode() async throws {
        let client = BitnodesClient()
        let response = try await client.checkNode(host: host, port: port)

        XCTAssertEqual(response.userAgent, "/Satoshi:23.0.0/")
        XCTAssertGreaterThanOrEqual(response.height, 740597)
    }

    func testGetNodeStatus() async throws {
        let client = BitnodesClient()
        let response = try await client.getNodeStatus(host: host, port: port)

        XCTAssertEqual(response.status, "UP")
        XCTAssertEqual(response.protocolVersion, 70016)
        XCTAssertEqual(response.userAgent, "/Satoshi:23.0.0/")
        XCTAssertGreaterThanOrEqual(response.height, 740597)
    }

}
