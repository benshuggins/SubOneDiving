//
//  QuoteView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/23/23.
//

import SwiftUI

struct QuoteView: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.marina)]) var customers: FetchedResults<Customer>
	
	let customer: Customer
	
	var body: some View {
		NavigationView {
			List {
				ForEach(customers) { customer in
					
					NavigationLink {
							PdfQuoteStartView(customer: customer)
					} label: {
						VStack(alignment: .leading) {
							Text(customer.wrappedName)
				
							Text(customer.wrappedMarina) // why arent default values showing up?
						}
					}
					
				}
			}
			.navigationTitle("Create Quote")
		}
	}
}

//NavigationLink {
//	CustomerDetailView(customer: customer)
//} label: {
//	VStack(alignment: .leading) {
//		Text(customer.wrappedName)
//		Text(customer.wrappedMarina) // why arent default values showing up?
//		}
//}

//struct QuoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteView()
//    }
//}
