import XCTest

class BlockchainClientTests: XCTestCase {

    func testGetTickers() async throws {
        let client = BlockchainClient()
        let tickers = try await client.getTickers()

        XCTAssertNotNil(tickers)
        XCTAssertGreaterThan(tickers.count, 0)
        XCTAssertEqual(tickers["USD"]?.symbol, "USD")
    }

}
