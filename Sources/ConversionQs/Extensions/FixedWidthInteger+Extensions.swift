//
//  File.swift
//  
//
//  Created by Antti Juustila on 14.9.2022.
//

import Foundation

extension FixedWidthInteger {
	/// Provides a binary representation of the value in format `0b10101010`.
	var binaryString: String {
		var result: [String] = []
		for i in 0..<(Self.bitWidth / 8) {
			let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
			let byteString = String(byte, radix: 2)
			let padding = String(repeating: "0",
										count: 8 - byteString.count)
			result.append(padding + byteString)
		}
		return "0b" + result.reversed().joined()
	}

}
