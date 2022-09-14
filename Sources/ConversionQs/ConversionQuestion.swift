//
//  File.swift
//  
//
//  Created by Antti Juustila on 14.9.2022.
//

import Foundation

struct ConversionQuestion {
	let question: String
	let answer: String
	let hint: String = """
			<p>Käsittele arvoja etumerkillisinä (signed) kahdeksan bitin tavuina.</p>
			<p>Kirjoita vastaukseen pyydetyn lukujärjestelmän etuliite (0x, 0b) jos se ei ole desimaali.</p>
			<p>Käytä vastauksessa muuten vain pyydetyn lukujärjestelmän numeroita, ei välilyöntejä tai muita välimerkkejä.</p>
		"""
	let hintEn: String = """
			<p>Consider the values to be signed bytes, with eight bits.</p>
			<p>Write in the answer the prefix for the radix (0x, 0b) asked, if it is not decimal.</p>
			<p>Otherwise, use only the digits of the requested numbering system, no spaces or other punctuations.</p>
		"""

	static let range: ClosedRange = Int8.min+1...Int8.max-1

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

	static func generate(using language: String) -> ConversionQuestion {
		var number: Int8 = range.randomElement()!
		while number == 0 {
			number = range.randomElement()!
		}
		let fromRadix = Radix.allCases.randomElement()!
		var toRadix = Radix.allCases.randomElement()!
		while fromRadix == toRadix {
			toRadix = Radix.allCases.randomElement()!
		}
		let fromValueAsString = toString(number, using: fromRadix)
		let toValueAsSring = toString(number, using: toRadix)
		var question: String
		if language == "fi" {
			question = String(format: "<p>Muunna arvo \(fromValueAsString) numerojärjestelmään: \(toRadix.asString(using: language)).</p>")
		} else if language == "en" {
			question = String(format: "<p>Convert the value \(fromValueAsString) to radix: \(toRadix.asString(using: language)).</p>")
		} else {
			question = "ERROR"
		}
		let answer = toValueAsSring
		return ConversionQuestion(question: question, answer: answer)
	}

	private static func toString(_ number: Int8, using radix: Radix) -> String {
		switch radix {
			case .dec:
				return String(format: "%d", number)
			case .hex:
				return String(format: "0x%x", number)
			case .bin:
				return number.binaryString
		}
	}
}
