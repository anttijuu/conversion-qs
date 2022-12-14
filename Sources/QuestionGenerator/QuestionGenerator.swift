import ArgumentParser

@main
/// A command line tool to generate simple, random radix conversion and arithmetic quizzes.
struct QuestionGenerator: ParsableCommand {

	@Argument(help: "Output file name.")
	var outputFile: String

	@Argument(help: "Number of questions to generate for each question type")
	var numberOfQuestions: Int = 10

	@Argument(help: "Language to generate, either fi or en.")
	var language: String = "fi"

	@Flag(help: "Include extra information in the console output.")
	var verbose = false

	static var configuration = CommandConfiguration(
		abstract: "A utility to generate both number conversion and basic math questions for Moodle quizzes.",
		version: "0.0.1"
	)

}

extension QuestionGenerator {

	mutating func run() {
		var questions = [any Question]()
		for _ in 1...numberOfQuestions {
			let question = ConversionQuestion.generate(using: language)
			questions.append(question)
			if verbose {
				print("---------------------------------")
				if language == "fi" {
					print("Kysymys: \(question.question)")
					print("Ohje: \(question.hint)")
					print("  Vastaus: \(question.answer)")

				} else if language == "en" {
					print("Question: \(question.question)")
					print("Instructions: \(question.hintEn)")
					print("Answer is: \(question.answer)")
				} else {
					print("Language must be either \"fi\" or \"en\"")
				}
			}
		}
		for _ in 1...numberOfQuestions {
			let question = AddQuestion.generate(using: language)
			questions.append(question)
			if verbose {
				print("---------------------------------")
				if language == "fi" {
					print("Kysymys: \(question.question)")
					print("Ohje: \(question.hint)")
					print("  Vastaus: \(question.answer)")

				} else if language == "en" {
					print("Question: \(question.question)")
					print("Instructions: \(question.hintEn)")
					print("Answer is: \(question.answer)")
				} else {
					print("Language must be either \"fi\" or \"en\"")
				}
			}
		}
		MoodleExporter.write(questions: questions, to: outputFile, using: language)
	}

}
