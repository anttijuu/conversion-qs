//
//  File.swift
//  
//
//  Created by Antti Juustila on 15.9.2022.
//

import Foundation

extension Int8 {
	/// Provides a string representation of the eight bit signed integer value using the provided radix.
	/// Hexadecimal values are prefixed with `0x`, binary values with `0b`. The length of the string
	/// always adheres to eight bits. For example, decimal value 4 in hex is `0x04` and binary: `0b00000100`.
	/// - Parameter radix: Radix to use.
	/// - Returns: The value as string, using given radix.
	func toString(using radix: Radix) -> String {
		var toReturn = ""
		switch radix {
			case .dec:
				toReturn = String(format: "%d", self)
			case .hex:
				// var result = String(number, radix: 16, uppercase: true)
				var result = String(format: "%X", self)
				if result.hasPrefix("-") {
					result.removeFirst()
					switch result.count {
						case 1:
							toReturn = "0xF" + result
						case 2:
							toReturn = "0x" + result
						default:
							break
					}
				} else {
					switch result.count {
						case 1:
							toReturn = "0x0" + result
						case 2:
							toReturn = "0x" + result
						default:
							toReturn = "0x" + String(result.suffix(2))
							break
					}
				}
			case .bin:
				toReturn = self.binaryString
		}
		return toReturn
	}
}

extension UInt8 {
	/// Provides a string representation of the eight bit unsigned integer value using the provided radix.
	/// Hexadecimal values are prefixed with `0x`, binary values with `0b`. The length of the string
	/// always adheres to eight bits. For example, decimal value 4 in hex is `0x04` and binary: `0b00000100`.
	/// - Parameter radix: Radix to use.
	/// - Returns: The value as string, using given radix.
	func toString(using radix: Radix) -> String {
		var toReturn = ""
		switch radix {
			case .dec:
				toReturn = String(format: "%d", self)
			case .hex:
				// var result = String(number, radix: 16, uppercase: true)
				var result = String(format: "%X", self)
				if result.hasPrefix("-") {
					result.removeFirst()
					switch result.count {
						case 1:
							toReturn = "0xF" + result
						case 2:
							toReturn = "0x" + result
						default:
							break
					}
				} else {
					switch result.count {
						case 1:
							toReturn = "0x0" + result
						case 2:
							toReturn = "0x" + result
						default:
							toReturn = "0x" + String(result.suffix(2))
							break
					}
				}
			case .bin:
				toReturn = self.binaryString
		}
		return toReturn
	}
}
