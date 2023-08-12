//
//  Job+CoreDataProperties.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/12/23.
//
//

import Foundation
import CoreData


extension Job {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var invoice: Int16
    @NSManaged public var jobType: String?
    @NSManaged public var nameJob: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var status: Int16
    @NSManaged public var origin: Customer?
	
	override public func awakeFromInsert() {
			super.awakeFromInsert()
			
			setPrimitiveValue(Date.now, forKey: "endDate")
		}


}

extension Job : Identifiable {

}
