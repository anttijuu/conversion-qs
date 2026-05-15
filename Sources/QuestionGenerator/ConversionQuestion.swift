//
//  ConversionQuestion.swift
//
//
//  Created by Antti Juustila on 14.9.2022.
//

import Foundation

/// A radix conversion question. Students are required to convert a number to a different radix.
class ConversionQuestion: Question {
	/// The question generated.
	let question: String
	/// The correct answer to the question.
	let answer: String
	/// Finnish instructions or hints on how to answer the question.
	var hints: [String] = [
		"Käsittele arvoja etumerkillisinä (signed) kahdeksan bitin tavuina.",
		"Käytä vastauksessa vain vastauksessa odotetun lukujärjestelmän numeroita, ei välilyöntejä tai muita välimerkkejä!"
	]
	/// English instructions or hints on how to answer the question.
	var hintsEn: [String] = [
		"Consider the values to be signed eight bit bytes.",
		"Use only the digits of the requested radix, no spaces or other punctuations!"
	]
	
	/// The title of the question. Visible only to Moodle teachers, not students.
	var title: String {
		get {
			"Muunna lukujärjestelmien (radix) välillä (id: \(UInt.random(in: 10_000...1_000_000)))"
		}
	}
	
	var titleEn: String {
		get {
			"Convert between radixes (id: \(UInt.random(in: 10000...1_000_000)))"
		}
	}
	
	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
	}
	
	/// The range of values to use in generating the questions.
	static let range: ClosedRange = Int8.min+1...Int8.max-1
	
	/// Generates one random radix conversion question.
	/// - Parameter language: The language to use in generating the question.
	/// - Returns: A random conversion question object.
	static func generate(using language: Language) -> ConversionQuestion {
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
		let answer = toValueAsSring
		
		switch language {
		case .fi:
			let question = String(format: "Muunna arvo \(fromValueAsString) numerojärjestelmään: \(toRadix.asString(using: language)).")
			let conversionQuestion = ConversionQuestion(question: question, answer: answer)
			if toRadix != .dec {
				conversionQuestion.hints.append(
					"Jos vastauksen lukujärjestelmä ei ole desimaali, kirjoita vastaukseen pyydetyn lukujärjestelmän etuliite, esimerkiksi: 0x2C tai 0b00010110 (eli 0x tai 0b)."
				)
				if toRadix == .bin {
					conversionQuestion.hints.append(
						"Binääriarvoja syöttäessäsi, vastauksessa pitää olla kahdeksan bittiä eli lisää etunollat, esimerkiksi: 0b00010110."
					)
				}
			}
			return conversionQuestion
		case .en:
			let question = String(format: "Convert the value \(fromValueAsString) to radix: \(toRadix.asString(using: language)).")
			let conversionQuestion = ConversionQuestion(question: question, answer: answer)
			if toRadix != .dec {
				conversionQuestion.hintsEn.append(
					"If the answer is not decimal, prefix the answer for the radix (0x, 0b) asked, e.g. 0x2C or 0b00010110."
				)
				if toRadix == .bin {
					conversionQuestion.hintsEn.append(
						"When entering binary values, the answer must include eight bits, so add the preceding zeroes, for example: 0b00010110."
					)
				}
			}
			return conversionQuestion
		}
	}
	
}
