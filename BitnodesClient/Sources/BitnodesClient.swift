import Foundation

class BitnodesClient {

    private static let baseUrl = URL(string: "https://bitnodes.io/api/v1")!

    private let urlSession = URLSession.init(configuration: .ephemeral)
    private let decoder = JSONDecoder()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func checkNode(host: String, port: Int) async throws -> CheckNodeResponse {
        var checkNodeRequest = URLRequest(url: Self.baseUrl.appendingPathComponent("/checknode/"))
        checkNodeRequest.httpMethod = "POST"
        checkNodeRequest.httpBody = "address=\(host)&port=\(port)".data(using: .utf8)
        checkNodeRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await urlSession.data(for: checkNodeRequest)

        return try decoder.decode(CheckNodeResponse.self, from: data)
    }

    func getNodeStatus(host: String, port: Int) async throws -> NodeStatusResponse {
        let nodeStatusUrl = Self.baseUrl.appendingPathComponent("/nodes/\(host)-\(port)/")
        let (data, _) = try await urlSession.data(from: nodeStatusUrl)

        return try decoder.decode(NodeStatusResponse.self, from: data)
    }

}
