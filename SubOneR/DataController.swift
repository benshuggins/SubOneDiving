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
		container.viewContext.automaticallyMergesChangesFromParent = true   // save to parent context
		container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
		container.loadPersistentStores { description, error in
			if let error {
				print("Core Data failed to load: \(error.localizedDescription)")
				return
			}
			
			
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
		
		func addCustomer(name: String, marina: String, customerDes: String, slip: String, vesselType: String, moc: NSManagedObjectContext) {
			
			let customer = Customer(context: moc)
			customer.id = UUID()
			customer.name = name
			customer.marina = marina
			customer.customerDes = customerDes
			customer.slip = slip
			customer.vesselType = vesselType
			customer.dateJoined = Date.now
			
			if moc.hasChanges {
				save(context: moc)
			}
			
			//try? moc.save()
		}
		
		func editCustomer(customer: Customer, name: String, slip: String, marina: String, gate: String, customerDes: String, moc: NSManagedObjectContext) {
			
			customer.name = name
			customer.marina = marina
			customer.customerDes = customerDes
			customer.slip = slip
			//	customer.vesselType = vesselType
			
			if moc.hasChanges {
				save(context: moc)
			}
		}
		
		
		//	let job1 = Job(context: moc)
		//	job1.nameJob = customer.wrappedName
		//	job1.invoice = Int16(invoice) ?? 0
		//	job1.jobType = jobType
		//	job1.startDate = startDate
		//	job1.endDate = completionDate
		//	job1.origin = customer //  Customer(context: moc) // attach to customer
		//	job1.status = Int16(status)
		//
		//	try? moc.save()
		
		func createNewJob(customer: Customer, nameJob: String, invoice: Int16, jobType: String, startDate: Date, completionDate: Date, status: Int16, moc: NSManagedObjectContext) {
			
			
			let job1 = Job(context: moc)
			job1.nameJob = customer.wrappedName
			job1.invoice = Int16(invoice) ?? 0
			job1.jobType = jobType
			job1.startDate = startDate
			job1.endDate = completionDate
			job1.origin = customer //  Customer(context: moc) // attach to customer
			job1.status = Int16(status)
			
			if moc.hasChanges {
				save(context: moc)
			}
		}
		
	// Shouldn't edit anything related to this customer here 
		
	func updateQuote(customer: Customer, job: Job, jobCurrentStatus: String, amount: Int, quoteNumber: String, moc: NSManagedObjectContext) {     // this should be sent a job
			//	customer.vesselType = vesselType

		job.jobCurrentStatus = jobCurrentStatus   // this changes quote status JOB/ QUOTE
		job.amount = Int16(Int(amount))
		


			if moc.hasChanges {
				save(context: moc)
			}
		}
	
	
	func updateJob(customer: Customer, job: Job, jobCurrentStatus: String, quoteNumber: String, moc: NSManagedObjectContext) {     // this should be sent a job
			//	customer.vesselType = vesselType

		job.jobCurrentStatus = jobCurrentStatus   // this changes quote status JOB/ QUOTE

		
			if moc.hasChanges {
				save(context: moc)
			}
		}
	}
	
	
	// I got uniquing so that common data cant be saved so the same customer cant be added in more than once 
	

