//
//  HTMLExporter.swift
//  QuestionGenerator
//
//  Created by Antti Juustila on 15.5.2026.
//

import Foundation

/// Exports an array of questions to a HTML file using a specified language.
enum HTMLExporter {
	
	/// This static method exports an array of different types of questions to a XML file using the specified language.
	/// The XML file format is the Moodle quiz XML format.
	///
	/// - Parameters:
	///   - questions: An array of questions.
	///   - file: The file name to store the questions.
	///   - language: One of the supported languages, currently "fi" or "en".
	static func write(questions: [Question], to file: String, using language: Language) {
		
		do {
			let fileURL = URL(fileURLWithPath: file)
			// File must exist before using file handle, so write an empty string to the file.
			try "".write(to: fileURL, atomically: true, encoding: .utf8)
			let handle = try FileHandle(forWritingTo: fileURL)
		
			let root = XMLElement(name: "html")
			let xml = XMLDocument(rootElement: root)
			let body = XMLElement(name: "body")
			
			for question in questions {
				
				let title = switch language {
				case .fi:
					question.title
				case .en:
					question.titleEn
				}
								
				let questionTitleElement = XMLElement(name: "h3", stringValue: title)
				body.addChild(questionTitleElement)
				let questionElement = XMLElement(name: "p", stringValue: question.question)
				body.addChild(questionElement)
				
				let hints = switch language {
				case .fi:
					question.hints
				case .en:
					question.hintsEn
				}
				let hintsNode = XMLElement(name: "ul")
				for hint in hints {
					let hintElement = XMLElement(name: "li", stringValue: hint)
					hintsNode.addChild(hintElement)
				}
				body.addChild((hintsNode))
				let answer = XMLElement(name: "pre", stringValue: "Answer (NOT to copy to question): \(question.answer)")
				body.addChild(answer)
			}
			root.addChild(body)
			handle.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>".data(using: .utf8)!)
			handle.write(xml.xmlString(options: [.nodePrettyPrint, .nodePreserveCDATA]).data(using: .utf8)!)
		} catch {
			fatalError("Error in creating Moodle quiz xml file, aborting \(error)")
		}

	}
	
}
