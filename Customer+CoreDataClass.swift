//
//  Customer+CoreDataClass.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/12/23.
//
//

import Foundation
import CoreData

@objc(Customer)
public class Customer: NSManagedObject {
	
	public var wrappedName: String {
		return name ?? "Name not given"
	}
	public var wrappedMarina: String {
		return marina ?? "Marina not given"
	}
	
	public var wrappedCustomerDesc: String {
		return customerDes ?? "unknown Customer description"
	}
	
	public var wrappedSlip: String {
		return slip ?? "Slip not given"
	}
	
	public var wrappedGate: String {
		return gate ?? "No gate added"
	}
	
	public var jobArray: [Job] {
		let set = job as? Set<Job> ?? []
		return set.sorted {
			$0.unwrappedNameJob > $1.unwrappedNameJob
		}
	}
}
