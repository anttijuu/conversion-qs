import XCTest
@testable import ConversionQs

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

	func testAdditions() throws {
		var testArray = [UnsignedTestNumber]()
		testArray.append(UnsignedTestNumber(valueA: 1, valueB: 2, answer: "3"))
		testArray.append(UnsignedTestNumber(valueA: 1, valueB: 9, answer: "10"))
		testArray.append(UnsignedTestNumber(valueA: 0x2A, valueB: 0b00000001, answer: "43"))
		testArray.append(UnsignedTestNumber(valueA: 0x0A, valueB: 0b00101010, answer: "84"))

		for testNumber in testArray {
			// XCTAssertEqual(testNumber.answer, )
		}
	}
}
