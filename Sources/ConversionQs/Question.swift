//
//  File.swift
//  
//
//  Created by Antti Juustila on 15.9.2022.
//

import Foundation

protocol Question {
	var title: String { get }
	var question: String { get }
	var answer: String { get }
	var hint: String { get }
	var hintEn: String { get }
}
