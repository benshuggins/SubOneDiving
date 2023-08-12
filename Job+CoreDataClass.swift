//
//  Job+CoreDataClass.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/12/23.
//
//

import Foundation
import CoreData

@objc(Job)
public class Job: NSManagedObject {

	public var unwrappedNameJob: String {
				nameJob ?? "Unknown job name"
			}

}
