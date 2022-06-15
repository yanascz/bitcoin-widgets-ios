import XCTest

class InputStreamTests: XCTestCase {

    func testReadBool() throws {
        let input = InputStream(data: Data([0x00, 0x01, 0xFA]))
        input.open(); defer { input.close() }

        XCTAssertFalse(input.readBool())
        XCTAssertTrue(input.readBool())
        XCTAssertTrue(input.readBool())
    }

    func testReadUInt16() throws {
        let input = InputStream(data: Data([0x01, 0x02]))
        input.open(); defer { input.close() }

        XCTAssertEqual(input.readUInt16(), UInt16(0x0102))
    }

    func testReadInt32() throws {
        let input = InputStream(data: Data([0x01, 0x02, 0x03, 0x04]))
        input.open(); defer { input.close() }

        XCTAssertEqual(input.readInt32(), Int32(0x04030201))
    }

    func testReadUInt32() throws {
        let input = InputStream(data: Data([0x01, 0x02, 0x03, 0x04]))
        input.open(); defer { input.close() }

        XCTAssertEqual(input.readUInt32(), UInt32(0x04030201))
    }

    func testReadInt64() throws {
        let input = InputStream(data: Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08]))
        input.open(); defer { input.close() }

        XCTAssertEqual(input.readInt64(), Int64(0x0807060504030201))
    }

    func testReadUInt64() throws {
        let input = InputStream(data: Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08]))
        input.open(); defer { input.close() }

        XCTAssertEqual(input.readUInt64(), UInt64(0x0807060504030201))
    }

    func testReadString() throws {
        let input = InputStream(data: Data([0x03, 0x66, 0x6F, 0x6F]))
        input.open(); defer { input.close() }

        XCTAssertEqual(input.readString(), "foo")
    }

    func testReadEmptyString() throws {
        let input = InputStream(data: Data([0x00]))
        input.open(); defer { input.close() }

        XCTAssertEqual(input.readString(), "")
    }

}
