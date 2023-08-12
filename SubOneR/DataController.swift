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
	
	func save(context: NSManagedObjectContext) {
		
		do {
			try context.save()
			print("Date saved successfully!")
		} catch {
			print("We could not save the data!")
		}
		
		
	}
	
	func addCustomer(name: String, marina: String, customerDes: String, slip: String, moc: NSManagedObjectContext) {
		
		let customer = Customer(context: moc)
		customer.id = UUID()
		customer.name = name
		customer.marina = marina
		customer.customerDes = customerDes
		customer.slip = slip
		customer.dateJoined = Date.now
		
		if moc.hasChanges {
			save(context: moc)
		}

		//try? moc.save()
	}
	
	func editCustomer(customer: Customer, name: String, slip: String, marina: String, gate: String, customerDes: String, vesselType: String, moc: NSManagedObjectContext) {
		 
		
		
	}
}


// I got uniquing so that common data cant be saved basically the same customer cant be added in more than once 


