import XCTest

class MempoolClientTests: XCTestCase {

    func testGetBlockHeight() async throws {
        let client = MempoolClient()
        let blockHeight = try await client.getBlockHeight()

        XCTAssertGreaterThanOrEqual(blockHeight, 755237)
    }

    func testGetRecommendedFees() async throws {
        let client = MempoolClient()
        let recommendedFees = try await client.getRecommendedFees()

        XCTAssertGreaterThanOrEqual(recommendedFees.fastestFee, 1)
        XCTAssertGreaterThanOrEqual(recommendedFees.halfHourFee, 1)
        XCTAssertGreaterThanOrEqual(recommendedFees.hourFee, 1)
        XCTAssertGreaterThanOrEqual(recommendedFees.economyFee, 1)
        XCTAssertGreaterThanOrEqual(recommendedFees.minimumFee, 1)
    }

}
