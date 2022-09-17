import XCTest
@testable import QuestionGenerator

struct SignedTestNumber {
	let value: Int8
	let hexValue: String
	let binValue: String
}

struct UnsignedTestNumber {
	let valueA: UInt8
	let valueB: UInt8
	let answer: String
}

final class ConversionQsTests: XCTestCase {

	func testConversions() throws {
		var testArray = [SignedTestNumber]()
		testArray.append(SignedTestNumber(value: 1, hexValue: "0x01", binValue: "0b00000001"))
		testArray.append(SignedTestNumber(value: 10, hexValue: "0x0A", binValue: "0b00001010"))
		testArray.append(SignedTestNumber(value: 42, hexValue: "0x2A", binValue: "0b00101010"))
		testArray.append(SignedTestNumber(value: 127, hexValue: "0x7F", binValue: "0b01111111"))
		testArray.append(SignedTestNumber(value: -42, hexValue: "0xD6", binValue: "0b11010110"))
		testArray.append(SignedTestNumber(value: -127, hexValue: "0x81", binValue: "0b10000001"))
		
		for testNumber in testArray {
			XCTAssertEqual(testNumber.hexValue, testNumber.value.toString(using: .hex))
			XCTAssertEqual(testNumber.binValue, testNumber.value.toString(using: .bin))
		}
	}

}
