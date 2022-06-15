import Foundation

struct NodeStatusResponse: Decodable {

    let status: String
    let protocolVersion: Int32
    let userAgent: String
    let height: Int32

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var dataContainer = try container.nestedUnkeyedContainer(forKey: .data)

        self.status = try container.decode(String.self, forKey: .status)
        self.protocolVersion = try dataContainer.decode(Int32.self)
        self.userAgent = try dataContainer.decode(String.self)
        _ = try dataContainer.decode(Int.self)
        _ = try dataContainer.decode(Int.self)
        self.height = try dataContainer.decode(Int32.self)
    }

    private enum CodingKeys: String, CodingKey {
        case status
        case data
    }

}
