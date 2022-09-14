import XCTest
@testable import ConversionQs

struct TestNumber {
	let intValue: Int8
	let hexValue: String
	let binValue: String
}

final class ConversionQsTests: XCTestCase {
	func testSampleNumbers() throws {
		var testArray = [TestNumber]()
		testArray.append(TestNumber(intValue: 1, hexValue: "0x01", binValue: "0b00000001"))
		testArray.append(TestNumber(intValue: 10, hexValue: "0x0A", binValue: "0b00001010"))
		testArray.append(TestNumber(intValue: 42, hexValue: "0x2A", binValue: "0b00101010"))
		testArray.append(TestNumber(intValue: 127, hexValue: "0x7F", binValue: "0b01111111"))
		testArray.append(TestNumber(intValue: -42, hexValue: "0xD6", binValue: "0b11010110"))
		testArray.append(TestNumber(intValue: -127, hexValue: "0x81", binValue: "0b10000001"))
		
		for testNumber in testArray {
			XCTAssertEqual(testNumber.hexValue, ConversionQuestion.toString(testNumber.intValue, using: .hex))
			XCTAssertEqual(testNumber.binValue, ConversionQuestion.toString(testNumber.intValue, using: .bin))
		}
	}
}
