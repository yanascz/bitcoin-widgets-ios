import Foundation

class MempoolClient {

    private static let baseUrl = URL(string: "https://mempool.space/api")!

    private let urlSession = URLSession.init(configuration: .ephemeral)
    private let decoder = JSONDecoder()

    func getBlockHeight() async throws -> Int32 {
        let blockHeightUrl = Self.baseUrl.appendingPathComponent("/blocks/tip/height")
        let (data, _) = try await urlSession.data(from: blockHeightUrl)

        return try decoder.decode(Int32.self, from: data)
    }

    func getRecommendedFees() async throws -> RecommendedFees {
        let recommendedFeesUrl = Self.baseUrl.appendingPathComponent("/v1/fees/recommended")
        let (data, _) = try await urlSession.data(from: recommendedFeesUrl)

        return try decoder.decode(RecommendedFees.self, from: data)
    }

}
