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

	@Argument(help: "Output format, either moodle or html.")
	var output: String = "html"

	@Flag(help: "Include extra information in the console output.")
	var verbose = false

	static var configuration = CommandConfiguration(
		abstract: "A utility to generate both number conversion and basic math questions for Moodle quizzes.",
		version: "0.1.0"
	)

}

extension QuestionGenerator {

	mutating func run() {
		guard output == "moodle" || output == "html" else {
			print("output must be either \"moodle\" or \"html\"")
			return
		}
		guard language == "fi" || language == "en" else {
			print("language must be either \"fi\" or \"en\"")
			return
		}
		guard numberOfQuestions > 0 else {
			print("Must generate one or more questions")
			return
		}
		let selectedLanguage = if language == "fi" { Language.fi } else if language == "en" { Language.en } else { Language.fi }
		var questions = [any Question]()
		for _ in 1...numberOfQuestions {
			let question = ConversionQuestion.generate(using: selectedLanguage)
			questions.append(question)
		}
		for _ in 1...numberOfQuestions {
			let question = AddQuestion.generate(using: selectedLanguage)
			questions.append(question)
		}
		if verbose {
			print("---Generated questions below---")
			for question in questions {
				print(question.title)
				print(question.question)
				for hint in question.hints {
					print(" - \(hint)")
				}
				print("[!! A: \(question.answer)]")
				print(" --- ")
			}
		}
		if (output == "moodle") {
			MoodleExporter.write(questions: questions, to: outputFile, using: selectedLanguage)
		} else if output == "html" {
			HTMLExporter.write(questions: questions, to: outputFile, using: selectedLanguage)
		}
		print("***** Done *****")
	}

}
