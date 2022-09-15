//
//  ConversionQuestion.swift
//  
//
//  Created by Antti Juustila on 14.9.2022.
//

import Foundation

class ConversionQuestion: Question {
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

	var title: String {
		get {
			"Muunna lukujärjestelmien välillä (convert between radixes)"
		}
	}

	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
	}

	static let range: ClosedRange = Int8.min+1...Int8.max-1

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
		if fromRadix == .dec && number < 0 {
			number = abs(number)
		}
		let fromValueAsString = number.toString(using: fromRadix)
		let toValueAsSring = number.toString(using: toRadix)
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


}
