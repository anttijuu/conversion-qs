import ArgumentParser

@main
struct ConversionQs: ParsableCommand {

	@Argument(help: "Number of questions to generate (default is 10)")
	var numberOfQuestions: Int = 10

	@Argument(help: "Language to generate, either fi or en (defaults to fi")
	var language: String = "fi"

	@Argument(help: "Output file name without the .xml extension")
	var outputFile: String

	@Flag(help: "Include extra information in the console output.")
	var verbose = false

	static var configuration = CommandConfiguration(
		abstract: "A utility to generate number conversion and basic math questions for Moodle quizzes.",
		version: "0.0.1"
	)

}
extension ConversionQs {

	mutating func run() {
		var questions = [ConversionQuestion]()
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
		MoodleExporter.write(questions: questions, to: outputFile, using: language)
	}

	
}
