//
//  MoodleExporter.swift
//  
//
//  Created by Antti Juustila on 14.9.2022.
//

import Foundation

struct MoodleExporter {

	static func write(questions: [Question], to file: String, using language: String) {
		do {
			let fileURL = URL(fileURLWithPath: file)
			try "".data(using: .utf8)?.write(to: fileURL)
			if let handle = try? FileHandle(forWritingTo: fileURL) {

				let root = XMLElement(name: "quiz")
				let xml = XMLDocument(rootElement: root)

				var counter: Int = 1
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
					questionText.addChild(XMLElement(name: "text", stringValue: wholeQuestion))
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
					counter += 1
				}

				handle.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>".data(using: .utf8)!)
				handle.write(xml.xmlString(options: .documentTidyXML).data(using: .utf8)!)
			} else {
				fatalError("Error in creating Moodle quiz xml file, aborting")
			}
		} catch {
			fatalError("Error in creating Moodle quiz xml file, aborting \(error)")
		}

	}

}
