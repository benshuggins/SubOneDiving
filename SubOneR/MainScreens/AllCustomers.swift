//
//  AllCustomers.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/7/23.
//

// populate the views with different sort descriptors tableView style

import SwiftUI

struct AllCustomers: View {
	
	@Environment(\.managedObjectContext) var moc
	
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.marina)]) var customers: FetchedResults<Customer>
	
    var body: some View {
		List {
			ForEach(customers) { customer in
				NavigationLink {
					
				} label: {
					VStack(alignment: .leading) {
						Text(customer.wrappedName)
						Text(customer.wrappedMarina) // why arent default values showing up?
						}
				}
			}
		}
    }
}

struct AllCustomers_Previews: PreviewProvider {
    static var previews: some View {
        AllCustomers()
    }
}
