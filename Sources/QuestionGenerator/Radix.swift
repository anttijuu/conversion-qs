//
//  Radix.swift
//  
//
//  Created by Antti Juustila on 15.9.2022.
//

import Foundation

enum Radix: CaseIterable {
	case dec
	case hex
	case bin

	func asString(using language: String) -> String {
		switch (self, language) {
			case (.dec, "fi"):
				return "desimaali"
			case (.hex, "fi"):
				return "heksadesimaali"
			case (.bin, "fi"):
				return "binääri"
			case (.dec, "en"):
				return "decimal"
			case (.hex, "en"):
				return "hexadecimal"
			case (.bin, "en"):
				return "binary"
			default:
				return "Error"
		}
	}
}
