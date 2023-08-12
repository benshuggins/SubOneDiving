//
//  FilteredListView.swift
//  SubOneR
//
//  Created by Ben Huggins on 6/29/23.
//
// THIS VIEW IS FOR FILTERING THE CUSTOMERS BY NAME, DATE, OR MARINA AND NEEDS TO BE REVISITED
// Need to make this generic and filter on predicates

//
//import SwiftUI
//
//struct FilteredListView: View {
//	@FetchRequest var fetchRequest: FetchedResults<Customer>
//	
//    var body: some View {
//		List(fetchRequest, id: \.self) { customer in
//			Text(customer.wrappedName)
//			Text(customer.wrappedMarina)
//		//	Text(customer.dateJoined)
//			
//		}
//    }
//	
//	init(filter: String) {
//		_fetchRequest = FetchRequest<Customer>(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", filter))
//	}
//}
//
////struct FilteredListView_Previews: PreviewProvider {
////    static var previews: some View {
////		FilteredListView(filter: filter)
////    }
////}
