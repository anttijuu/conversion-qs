//
//  File.swift
//  
//
//  Created by Antti Juustila on 15.9.2022.
//

import Foundation

/// The interface to different question types.
protocol Question {
	var title: String { get }
	var titleEn: String { get }
	var question: String { get }
	var answer: String { get }
	var hints: [String] { get }
	var hintsEn: [String] { get }
}
