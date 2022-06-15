import Foundation

extension InputStream {

    func readBool() -> Bool {
        var value: UInt8 = 0
        read(to: &value, count: MemoryLayout<UInt8>.size)

        return value > 0
    }

    func readUInt16() -> UInt16 {
        var value: UInt16 = 0
        read(to: &value, count: MemoryLayout<UInt16>.size)

        return value.bigEndian
    }

    func readInt32() -> Int32 {
        var value: Int32 = 0
        read(to: &value, count: MemoryLayout<Int32>.size)

        return value.littleEndian
    }

    func readUInt32() -> UInt32 {
        var value: UInt32 = 0
        read(to: &value, count: MemoryLayout<UInt32>.size)

        return value.littleEndian
    }

    func readInt64() -> Int64 {
        var value: Int64 = 0
        read(to: &value, count: MemoryLayout<Int64>.size)

        return value.littleEndian
    }

    func readUInt64() -> UInt64 {
        var value: UInt64 = 0
        read(to: &value, count: MemoryLayout<UInt64>.size)

        return value.littleEndian
    }

    func readData(count: Int) -> Data {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        read(buffer, maxLength: count)

        return Data(bytes: buffer, count: count)
    }

    func readString() -> String {
        // TODO: use variable length integer decoding
        var count: UInt8 = 0
        read(&count, maxLength: MemoryLayout<UInt8>.size)
        let data = readData(count: Int(count))

        return String(bytes: data, encoding: .ascii)!
    }

    private func read<T>(to target: inout T, count: Int) {
        _ = withUnsafeMutablePointer(to: &target) {
            self.read($0, maxLength: count)
        }
    }

}
