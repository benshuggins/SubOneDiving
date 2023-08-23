//
//  Customer+CoreDataProperties.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/15/23.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var customerDes: String?
    @NSManaged public var dateJoined: Date?
    @NSManaged public var gate: String?
    @NSManaged public var id: UUID?
    @NSManaged public var marina: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: Int16
    @NSManaged public var slip: String?
    @NSManaged public var vesselType: String?
    @NSManaged public var job: NSSet?

}

// MARK: Generated accessors for job
extension Customer {

    @objc(addJobObject:)
    @NSManaged public func addToJob(_ value: Job)

    @objc(removeJobObject:)
    @NSManaged public func removeFromJob(_ value: Job)

    @objc(addJob:)
    @NSManaged public func addToJob(_ values: NSSet)

    @objc(removeJob:)
    @NSManaged public func removeFromJob(_ values: NSSet)

}

extension Customer : Identifiable {

}
