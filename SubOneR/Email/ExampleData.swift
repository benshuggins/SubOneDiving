//
//  ExampleData.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/16/23.
//

import Foundation


struct ExampleData: Encodable, Identifiable {
	let id = UUID()
	let name: String
	let image: String
	
	static var examples: [ExampleData] {
		[
			ExampleData(name: "Approval Inspection Report - Anthony Saviano you Get This???", image: "🏀"),
			ExampleData(name: "Hull Clean2", image: "⚽️"),
			ExampleData(name: "Hull Clean3", image: "🏉"),
			ExampleData(name: "Hull Clean4", image: "🏈"),
			ExampleData(name: "Hull Clean5", image: "🎾"),
			ExampleData(name: "Hull Clean6", image: "⚾️"),
			ExampleData(name: "Hull Clean7", image: "🏐"),
			ExampleData(name: "Hull Clean8", image: "🎱")
		]
	}
	
	static var data: Data? {
		try? JSONEncoder().encode(examples)
	}
}
