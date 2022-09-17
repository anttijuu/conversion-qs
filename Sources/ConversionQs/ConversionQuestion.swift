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
	let hint: String = """
			<p>Käsittele arvoja etumerkillisinä (signed) kahdeksan bitin tavuina.</p>
			<p>Kirjoita vastaukseen pyydetyn lukujärjestelmän etuliite (0x, 0b) jos se ei ole desimaali, esimerkiksi: 0x2C tai 0b00010110.</p>
			<p>Käytä vastauksessa muuten vain pyydetyn lukujärjestelmän numeroita, ei välilyöntejä tai muita välimerkkejä!</p>
		"""
	/// English instructions or hints on how to answer the question.
	let hintEn: String = """
			<p>Consider the values to be signed bytes, with eight bits.</p>
			<p>Include in the answer the prefix for the radix (0x, 0b) asked, if it is not decimal, e.g. 0x2C or 0b00010110.</p>
			<p>Otherwise, use only the digits of the requested numbering system, no spaces or other punctuations!</p>
		"""

	/// The title of the question. Visible only to Moodle teachers, not students.
	var title: String {
		get {
			"Muunna lukujärjestelmien välillä (convert between radixes) \(UInt.random(in: 10000...50000))"
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
