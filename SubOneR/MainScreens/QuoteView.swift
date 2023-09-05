//
//  QuoteView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/23/23.
//

// 1 Look at Hacking with swift and fetch only status = jobs 

//import SwiftUI
//
//struct QuoteView: View {
//	@Environment(\.managedObjectContext) var moc
//	//@FetchRequest(sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.marina)]) var customers: FetchedResults<Customer>
//	
////	@FetchRequestvar (sortDescriptors: [SortDescriptor(\.name), ) var customers: FetchedResults<Customer>
//										
//	//@FetchRequest(sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.marina], predicate: nil) var customers: FetchedResults<Customer>
//	
//	//let customer: Customer
//	
//	var body: some View {
//		NavigationView {
//			List {
//				ForEach(customers) { customer in
//					
//					NavigationLink {
//							PdfQuoteStartView(customer: customer)
//					} label: {
//						VStack(alignment: .leading) {
//							Text(customer.wrappedName)
//				
//							Text(customer.wrappedMarina) // why arent default values showing up?
//						}
//					}
//					
//				}
//			}
//			.navigationTitle("Jobs Only")
//		}
//	}
//}

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
