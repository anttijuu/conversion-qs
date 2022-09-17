# ConversionQs

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

Generated questions with correct answers and default grading are saved into a Moodle quiz XML file. The file can then be imported to Moodle question bank.

## Building

The tool depends on Swift argument parser, as can be seen from the `Package.swift` file.

From the terminal, build the tool:

```console
swift build -c release
```

Or open the `Package.swift` file from Xcode.

## Running

Run the tool from Xcode, first editing the Product scheme having suitable arguments the tool requires. 
 
Or run the tool from command line, with suitable argument values, e.g.:

```console
./.build/release/ConversionQs 20 en output-en.xml --verbose
```

Three arguments are required, the `--verbose` flag being optional:

1. Number of each question type to generate. Value 20 generates 20 conversion and 20 addition questions.
2. Language of the questions, "fi" for Finnish, "en" for English.
3. The output XML file name.
4. --verbose flag prints progress information, not providing the flag the tool prints nothing. 

## License

MIT License. See the LICENSE file for details.

## Who did this

(c) Antti Juustila, 2022 All Rights Reserved.
INTERACT Research Group, University of Oulu, Finland

