//
//  AddQuestions.swift
//  
//
//  Created by Antti Juustila on 15.9.2022.
//

import Foundation

class AddQuestion: Question {
	let question: String
	let answer: String
	let hint: String = """
  <p>Käsittele arvoja etumerkittöminä (unsigned) kahdeksan bitin tavuina.</p>
  """
	let hintEn: String = """
  <p>Consider the values to be unsigned eight bits.</p>
  """

	var title: String {
		get {
			"Suorita laskutehtävä (calculate numbers) \(UInt.random(in: 10000...50000))"
		}
	}

	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
	}

	static let range: ClosedRange = UInt8.min...UInt8.max/2 - 1

	static func generate(using language: String) -> AddQuestion {
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
		if language == "fi" {
			question = String(format: "<p>Anna seuraavan laskuoperaation tulos desimaalinumerona: \(valueOfAAsString) + \(valueOfBAsString)</p>")
		} else if language == "en" {
			question = String(format: "<p>What is the result of the calculation as decimal number: \(valueOfAAsString) + \(valueOfBAsString)</p>")
		} else {
			question = "ERROR"
		}
		let answer = (numberA + numberB).toString(using: .dec)
		return AddQuestion(question: question, answer: answer)
	}

}
