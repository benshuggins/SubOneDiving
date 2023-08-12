//
//  DataController.swift
//  SubOneR
//
//  Created by Ben Huggins on 6/28/23.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
	
	let container = NSPersistentContainer(name: "SubOneR")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Core Data failed to load: \(error.localizedDescription)")
				return
			}
			
			self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
		}
	}
}


// I got uniquing so that common data cant be saved basically the same customer cant be added in more than once 
