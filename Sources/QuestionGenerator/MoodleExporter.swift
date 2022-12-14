//
//  MoodleExporter.swift
//  
//
//  Created by Antti Juustila on 14.9.2022.
//

import Foundation

/// Exports an array of questions to a XML file using a specified language.
enum MoodleExporter {

	/// This static method exports an array of different types of questions to a XML file using the specified language.
	/// The XML file format is the Moodle quiz XML format.
	/// 
	/// - Parameters:
	///   - questions: An array of questions.
	///   - file: The file name to store the questions.
	///   - language: One of the supported languages, currently "fi" or "en".
	static func write(questions: [Question], to file: String, using language: String) {
		do {
			let fileURL = URL(fileURLWithPath: file)
			// File must exist before using file handle, so write an empty string to the file.
			try "".write(to: fileURL, atomically: true, encoding: .utf8)
			let handle = try FileHandle(forWritingTo: fileURL)

			let root = XMLElement(name: "quiz")
			let xml = XMLDocument(rootElement: root)

			for question in questions {
				// Create one question
				let questionElement = XMLElement(name: "question")
				questionElement.addAttribute(XMLNode.attribute(withName: "type", stringValue: "shortanswer") as! XMLNode)
				// Add question name, not visible to student
				let nameNode = XMLElement(name: "name")
				// Add the actual question text visible to student as plain text
				nameNode.addChild(XMLElement(name: "text", stringValue: question.title))
				questionElement.addChild(nameNode)
				let questionText = XMLElement(name: "questiontext")
				questionText.addAttribute(XMLNode.attribute(withName: "format", stringValue: "html") as! XMLNode)

				let hint = language == "fi" ? question.hint : question.hintEn
				let wholeQuestion = "\(question.question) \(hint)"

				let element = XMLElement(name: "text", stringValue: wholeQuestion)
				// Trying to get the HTML formatted question inside a CDATA element so that tags would
				// not be escaped, but could not get this to work.
				//	let element = XMLElement(kind: .element, options: [.nodeIsCDATA, .nodeNeverEscapeContents])
				//	element.name = "text"
				//	element.setStringValue(wholeQuestion, resolvingEntities: false)
				questionText.addChild(element)
				questionElement.addChild(questionText)

				let defaultGrade = XMLElement(name: "defaultgrade", stringValue: "2.0000000")
				questionElement.addChild(defaultGrade)
				let penalty = XMLElement(name: "penalty", stringValue: "0.3333333")
				questionElement.addChild(penalty)
				// Add the correct answer to the question
				let answer = XMLElement(name: "answer")
				answer.addAttribute(XMLNode.attribute(withName: "fraction", stringValue: "100") as! XMLNode)
				answer.addAttribute(XMLNode.attribute(withName: "format", stringValue: "moodle_auto_format") as! XMLNode)
				answer.addChild(XMLElement(name: "text", stringValue: question.answer))
				questionElement.addChild(answer)
				// Add the question to the set of questions
				root.addChild(questionElement)
			}

			handle.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>".data(using: .utf8)!)
			handle.write(xml.xmlString(options: [.nodePrettyPrint, .nodePreserveCDATA]).data(using: .utf8)!)
		} catch {
			fatalError("Error in creating Moodle quiz xml file, aborting \(error)")
		}
	}
}
