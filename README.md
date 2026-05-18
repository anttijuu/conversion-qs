# QuestionGenerator

This command line tool generates random numbering system (radix) questions for quizzes or exams. The question languages supported are Finnish and English.

The questions are either simple radix conversion questions, for example:

```
Convert between radixes (id: 902575)
Convert the value 0b10101000 to radix: decimal.
 - Treat the values as signed eight bit bytes and integers.
 - In your answer, use only digits from the expected numbering system (radix), no spaces nor other punctiation characters!
```

Or simple arithmetic add operations:

```
Solve the calculation (id: 26562)
What is the result of this calculation as a decimal system number: 0x31 + 86
 - Consider the values to be unsigned eight bits and integers.
 - In your answer use only digits, no characters, punctuations, spaces or other symbols
```

Both question types use eight bit integer values. Add questions use only positive (unsigned) eight bit values.

Generated questions with correct answers and default grading are saved into either

* a Moodle quiz XML file. The file can then be imported to Moodle question bank.
* as a HTML document, from where to copy the HTML formatted questions to a web based exam system. 

A small sample HTML output file is included in [test.html](test.html). Each question begins from it's own `<h3>` level
header.

## Building

The tool depends on Swift argument parser, as can be seen from the `Package.swift` file.

From the terminal, build the tool:

```console
swift build -c release
```

Or open the `Package.swift` file from Xcode.

## Running

Run the tool from Xcode, first editing the Product scheme having suitable arguments the tool requires (see below). 
 
Or run the tool from command line, with suitable argument values, e.g.:

```console
./.build/release/QuestionGenerator test.html 20 fi html
```

First argument is required, the others being optional with default values:

1. The output file name. If the file exists, it is overwritten.
2. Number of each question type to generate. Value 20 generates 20 conversion and 20 addition questions.
3. Language of the questions, "fi" for Finnish, "en" for English.
4. Format of the output, either "html" or "moodle" for Moodle XML format.
4. --verbose flag prints progress information. If not provided the tool prints nothing when all goes OK. 

Run the command with `-h`flag to see the instructions:

```console
> ./.build/release/QuestionGenerator -h
OVERVIEW: A utility to generate both number conversion and basic math questions for Moodle quizzes.

USAGE: QuestionGenerator <output-file> [<number-of-questions>] [<language>] [<output>] [--verbose]

ARGUMENTS:
  <output-file>           Output file name.
  <number-of-questions>   Number of questions (10 by default) to generate for each question type (default: 10)
  <language>              Language to generate, either fi (default) or en. (default: fi)
  <output>                Output format, either moodle or html (default). (default: html)

OPTIONS:
  --verbose               Include extra information in the console output.
  --version               Show the version.
  -h, --help              Show help information.
```

If you wish to get plain text output, use either moodle or html output format and use the `--verbose` flag:

```console
> .build/debug/QuestionGenerator test.html 1 en html --verbose
---Generated questions below---
Convert between radixes (id: 902575)
Convert the value 0b10101000 to radix: decimal.
 - Treat the values as signed eight bit bytes and integers.
 - In your answer, use only digits from the expected numbering system (radix), no spaces nor other punctiation characters!
[!! A: -88]
 --- 
Solve the calculation (id: 26562)
What is the result of this calculation as a decimal system number: 0x31 + 86
 - Consider the values to be unsigned eight bits and integers.
 - In your answer use only digits, no characters, punctuations, spaces or other symbols
[!! A: 135]
 --- 
***** Done *****
```

Then you can copy the question text from the console (or redirect it into a file or the clipboard). 

In all output formats, take care *not* to include the correct answer in the question text for the students. The answer line is shown above starting with `[!! A:`. See the html version in browser and note that the aswer is shown in fixed with string style (within `<pre></pre>` element).


## Contributing

If you find any issues or places for improvement, you may either:

* Report an issue using GitHub issues for this project, or
* Fork the repository, clone it, create a branch for your fix or enhancement, push it to your fork and then create a pull request to this repository. Consider adding any suitable unit tests in the Tests folder.

## License

MIT License. See the LICENSE file for details.

## Who did this?

* (c) Antti Juustila, 2022-2026. 
* All Rights Reserved.
* INTERACT Research Group,
* Sofware Engineering and Information Systems 
* University of Oulu, Finland

