import Foundation
import CryptoKit

extension Data {

    mutating func append(_ value: Bool) {
        append(UInt8(value ? 0x01 : 0x00))
    }

    mutating func append(_ value: UInt16) {
        append(Swift.withUnsafeBytes(of: value.bigEndian) { Data($0) })
    }

    mutating func append(_ value: Int32) {
        append(Swift.withUnsafeBytes(of: value.littleEndian) { Data($0) })
    }

    mutating func append(_ value: UInt32) {
        append(Swift.withUnsafeBytes(of: value.littleEndian) { Data($0) })
    }

    mutating func append(_ value: Int64) {
        append(Swift.withUnsafeBytes(of: value.littleEndian) { Data($0) })
    }

    mutating func append(_ value: UInt64) {
        append(Swift.withUnsafeBytes(of: value.littleEndian) { Data($0) })
    }

    mutating func append(_ value: String) {
        // TODO: use variable length integer encoding
        append(UInt8(value.count))
        append(value.data(using: .ascii)!)
    }

    var checksum: UInt32 {
        let hash: Data = Data(SHA256.hash(data: Data(SHA256.hash(data: self))))
        let b1 = UInt32(hash[0])
        let b2 = UInt32(hash[1]) << 8
        let b3 = UInt32(hash[2]) << 16
        let b4 = UInt32(hash[3]) << 24

        return b1 + b2 + b3 + b4
    }

}
