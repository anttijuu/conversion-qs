//
//  AddQuestions.swift
//
//
//  Created by Antti Juustila on 15.9.2022.
//

import Foundation


/// Add question type generates simple arithmetic add questions using unsigned byte values.
class AddQuestion: Question {
	/// The generated question text.
	let question: String
	/// The answer to the question.
	let answer: String
	/// Hints or instructions on how to answer the question (Finnish).
	let hints: [String] = [
		"Käsittele arvoja etumerkittöminä (unsigned) kahdeksan bitin tavuina.",
		"Anna vastauksena vain numeroita, ei kirjainmerkkejä, välimerkkejä, välilyöntejä tai muuta"
	]
	/// Hints or instructions on how to answer the question (English).
	let hintsEn: [String] = [
		"Consider the values to be unsigned eight bits.",
		"In your answer use only numbers, no characters, punctuations, spaces or other symbols"
	]
	
	/// Title of the question, not visible to students in Moodle, only to teachers.
	var title: String {
		get {
			"Suorita laskutehtävä (id: \(UInt.random(in: 10000...50000)))"
		}
	}
	
	var titleEn: String {
		get {
			"Calculate the numbers (id: \(UInt.random(in: 10000...50000)))"
		}
	}
	
	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
	}
	
	/// The range of values to use when generating the question.
	static let range: ClosedRange = UInt8.min...UInt8.max/2 - 1
	
	/// Generates one random question.
	/// - Parameter language: The language to use in generating the question.
	/// - Returns: Returns a new question object.
	static func generate(using language: Language) -> AddQuestion {
		var numberA: UInt8 = range.randomElement()!
		while numberA == 0 {
			numberA = range.randomElement()!
		}
		var numberB: UInt8 = range.randomElement()!
		while numberB == 0 {
			numberB = range.randomElement()!
		}
		let radixOfA = Radix.allCases.randomElement()!
		var radixOfB = Radix.allCases.randomElement()!
		while radixOfA == radixOfB {
			radixOfB = Radix.allCases.randomElement()!
		}
		let valueOfAAsString = numberA.toString(using: radixOfA)
		let valueOfBAsString = numberB.toString(using: radixOfB)
		var question: String
		switch language {
		case .fi:
			question = String(format: "Anna seuraavan laskuoperaation tulos kymmenlukujärjestelmän numerona: \(valueOfAAsString) + \(valueOfBAsString)")
		case .en:
			question = String(format: "What is the result of this calculation as a decimal system number: \(valueOfAAsString) + \(valueOfBAsString)")
		}
		let answer = (numberA + numberB).toString(using: .dec)
		return AddQuestion(question: question, answer: answer)
	}
	
}
