//
//  Job+CoreDataProperties.swift
//  SubOneR
//
//  Created by Ben Huggins on 9/5/23.
//
//

import Foundation
import CoreData


extension Job: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var invoice: Int16
    @NSManaged public var jobCurrentStatus: String?
    @NSManaged public var jobType: String?
    @NSManaged public var nameJob: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var status: Int16
    @NSManaged public var amount: Int16
    @NSManaged public var origin: Customer?
	
	public override func awakeFromInsert() {
		super.awakeFromInsert()
		
		setPrimitiveValue("Quote", forKey: "jobCurrentStatus")
	}

}

//extension Job : Identifiable {
//
//}
