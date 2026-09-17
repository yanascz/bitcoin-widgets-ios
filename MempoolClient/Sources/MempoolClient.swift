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

    func getBlockHeightByDate(_ date: Date) async throws -> Int32 {
        struct BlockInfo: Decodable {
            let height: Int32
        }

        let blockInfoByTimestampUrl = Self.baseUrl.appendingPathComponent(
            "/v1/mining/blocks/timestamp/\(Int(date.timeIntervalSince1970))"
        )
        let (data, _) = try await urlSession.data(from: blockInfoByTimestampUrl)
        let blockInfo = try decoder.decode(BlockInfo.self, from: data)

        return blockInfo.height
    }

    func getPreciseFees() async throws -> PreciseFees {
        let preciseFeesUrl = Self.baseUrl.appendingPathComponent("/v1/fees/precise")
        let (data, _) = try await urlSession.data(from: preciseFeesUrl)

        return try decoder.decode(PreciseFees.self, from: data)
    }

}
