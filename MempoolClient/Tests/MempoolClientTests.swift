import XCTest

class MempoolClientTests: XCTestCase {

    func testGetBlockHeight() async throws {
        let client = MempoolClient()
        let blockHeight = try await client.getBlockHeight()

        XCTAssertGreaterThanOrEqual(blockHeight, 755237)
    }

    func testGetBlockHeightByDate() async throws {
        let client = MempoolClient()
        let blockHeight = try await client.getBlockHeightByDate(Date())

        XCTAssertGreaterThanOrEqual(blockHeight, 826153)
    }

    func testGetPreciseFees() async throws {
        let client = MempoolClient()
        let preciseFees = try await client.getPreciseFees()

        XCTAssertGreaterThanOrEqual(preciseFees.fastestFee, 0.1)
        XCTAssertGreaterThanOrEqual(preciseFees.halfHourFee, 0.1)
        XCTAssertGreaterThanOrEqual(preciseFees.hourFee, 0.1)
        XCTAssertGreaterThanOrEqual(preciseFees.economyFee, 0.1)
        XCTAssertGreaterThanOrEqual(preciseFees.minimumFee, 0.1)
    }

}
