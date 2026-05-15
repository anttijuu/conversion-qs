# QuestionGenerator

This command line tool generates random numbering system (radix) questions for quizzes or exams. The question languages supported are Finnish and English.

The questions are either simple radix conversion questions, for example:

> Convert the value 107 to radix: hexadecimal.
> Consider the values to be signed bytes, with eight bits.
> Include in the answer the prefix for the radix (0x, 0b) asked, if it is not decimal, e.g. 0x2C or 0b00010110.
> Otherwise, use only the digits of the requested numbering system, no spaces or other punctuations!

Or simple arithmetic add operations:

> What is the result of the calculation as decimal number: 32 + 0x29
> Consider the values to be unsigned eight bits.

Both question types use eight bit integer values. Add questions use only positive (unsigned) eight bit values.

Generated questions with correct answers and default grading are saved into either

* a Moodle quiz XML file. The file can then be imported to Moodle question bank.
* as a HTML document, from where to copy the HTML formatted questions to a web based exam system. 

A simple sample HTML output file is included in [test.html](test.html).

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

First argument is required, the rest being optional with default values:

1. The output XML file name. If the file exists, it is overwritten.
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
 ---
Subject: Muunna lukujärjestelmien (radix) välillä (id: 42079)
Question: Convert the value 67 to radix: binary.
Instructions:
 - Consider the values to be signed eight bit bytes.
 - If the answer is not decimal, prefix the answer for the radix (0x, 0b) asked, e.g. 0x2C or 0b00010110.
 - When entering binary values, the answer must include eight bits, so add the preceding zeroes, for example: 0b00010110.
 - Otherwise, use only the digits of the requested radix, no spaces or other punctuations!
!! Correct answer is: 0b01000011
 ---
Subject: Suorita laskutehtävä (id: 17936)
Question: What is the result of the calculation as a decimal system number: 0b00110110 + 0x30
Instructions:
 - Consider the values to be unsigned eight bits.
 - In your answer use only numbers, no characteres, punctiations, spaces or other symbols
!! Correct answer is: 102
-- Done -- 
```
Then you can copy the question text from the console (or redirect it into a file or clipboard). 

In all output formats, take care *not* to include the correct answer in the question text for the students...


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

