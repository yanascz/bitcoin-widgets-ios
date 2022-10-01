import Foundation

class BlockchainClient {

    private static let baseUrl = URL(string: "https://blockchain.info")!

    private let urlSession = URLSession.init(configuration: .ephemeral)
    private let decoder = JSONDecoder()

    func getTickers() async throws -> [String: Ticker] {
        let tickersUrl = Self.baseUrl.appendingPathComponent("/ticker")
        let (data, _) = try await urlSession.data(from: tickersUrl)

        return try decoder.decode([String: Ticker].self, from: data)
    }

}
