import XCTest

class DataTests: XCTestCase {

    func testAppendBool() throws {
        var data = Data()
        data.append(true)
        data.append(false)

        XCTAssertEqual(data, Data([0x01, 0x00]))
    }

    func testAppendUInt16() throws {
        var data = Data()
        data.append(UInt16(0x0102))

        XCTAssertEqual(data, Data([0x01, 0x02]))
    }

    func testAppendInt32() throws {
        var data = Data()
        data.append(Int32(0x04030201))

        XCTAssertEqual(data, Data([0x01, 0x02, 0x03, 0x04]))
    }

    func testAppendUInt32() throws {
        var data = Data()
        data.append(UInt32(0x04030201))

        XCTAssertEqual(data, Data([0x01, 0x02, 0x03, 0x04]))
    }

    func testAppendInt64() throws {
        var data = Data()
        data.append(Int64(0x0807060504030201))

        XCTAssertEqual(data, Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08]))
    }

    func testAppendUInt64() throws {
        var data = Data()
        data.append(UInt64(0x0807060504030201))

        XCTAssertEqual(data, Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08]))
    }

    func testAppendString() throws {
        var data = Data()
        data.append("foo")

        XCTAssertEqual(data, Data([0x03, 0x66, 0x6F, 0x6F]))
    }

    func testAppendEmptyString() throws {
        var data = Data()
        data.append("")

        XCTAssertEqual(data, Data([0x00]))
    }

    func testChecksum() throws {
        let data = "hello".data(using: .ascii)!

        XCTAssertEqual(data.checksum, UInt32(0xDFC99595))
    }

}
