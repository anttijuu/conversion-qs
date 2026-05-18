//
//  AddQuestions.swift
//
//
//  Created by Antti Juustila on 15.9.2022.
//

import Foundation


/// Add question type generates simple arithmetic add questions using unsigned byte values.
class AddQuestion: Question {
	/// Title of the question.
	let title: String
	/// The generated question text.
	let question: String
	/// The answer to the question.
	let answer: String
	/// Hints or instructions on how to answer the question.
	let hints: [String]
	
	init(title: String,
		  question: String,
		  answer: String,
		  hints: [String]
	) {
		self.title = title
		self.question = question
		self.answer = answer
		self.hints = hints
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
		while radixOfA == .dec && radixOfB == .dec {
			radixOfB = Radix.allCases.randomElement()!
		}
		let valueOfAAsString = numberA.toString(using: radixOfA)
		let valueOfBAsString = numberB.toString(using: radixOfB)
		var question: String
		// Make sure the toString is the correct number using Int conversion
		let answer = (numberA + numberB).toString(using: .dec)
		precondition(Int(answer) == Int(numberA+numberB))
		
		switch language {
		case .fi:
			question = String(format: "Anna seuraavan laskuoperaation tulos kymmenlukujärjestelmän numerona: \(valueOfAAsString) + \(valueOfBAsString)")
			return AddQuestion(
				title: "Suorita laskutehtävä (id: \(UInt.random(in: 10000...50000)))",
				question: question,
				answer: answer,
				hints: [
					"Käsittele arvoja etumerkittöminä (unsigned) kahdeksan bitin tavuina ja kokonaislukuina.",
					"Anna vastauksena vain numeroita, ei kirjainmerkkejä, välimerkkejä, välilyöntejä tai muuta"
				]
			)
		case .en:
			question = String(format: "What is the result of this calculation as a decimal system number: \(valueOfAAsString) + \(valueOfBAsString)")
			return AddQuestion(
				title: "Solve the calculation (id: \(UInt.random(in: 10000...50000)))",
				question: question,
				answer: answer, hints: [
					"Consider the values to be unsigned eight bits and integers.",
					"In your answer use only digits, no characters, punctuations, spaces or other symbols"
				]
			)
		}
	}
	
}
