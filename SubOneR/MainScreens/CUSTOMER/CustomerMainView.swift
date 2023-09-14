//
//  ContentView.swift
//  SubOneR
//
//  Created by Ben Huggins on 6/28/23.
//https://www.hackingwithswift.com/books/ios-swiftui/core-data-wrap-up

// awake from insert to preset core data values
// Manually writing CD models out with Computed Poperty Module set and with manual/none
// Place preview in a NavigationStack to see
// Navigation stack to push views to see title
// subclass your views
// .primary action for buttons to tell screen what is the main action 

import SwiftUI
import CoreData

struct CustomerMainView: View {
	
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.marina)]) var customers: FetchedResults<Customer>
	@Environment(\.dismiss) var dismiss
	
	@State private var needsRefresh: Bool = false
	@State private var showingAddScreen = false
	@State private var showingUpdateScreen = false
	
    var body: some View {
		NavigationView {
			List {
				ForEach(customers) { customer in
					NavigationLink {
						CustomerDetailView(customer: customer)
					} label: {
						CustomerRowView(customer: customer)
					}
				}
				.onDelete(perform: deleteCustomers)
				}
				.navigationTitle("SubOne Client's")
				//.navigationBarTitleDisplayMode(.inline)
				.navigationViewStyle(StackNavigationViewStyle())
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button {
							showingAddScreen.toggle()
						} label: {
							Label("Add Customer", systemImage: "plus")
						}
					}
				}
				.sheet(isPresented: $showingAddScreen) {
					NavigationStack {
						AddCustomerView(needsRefresh: $needsRefresh)
					}
				}
    }
}
	
	func deleteCustomers(at offsets: IndexSet) {
		for offset in offsets {
			// find this book in our fetch request
			let customer = customers[offset]

			// delete it from the context
			moc.delete(customer)
		}

		do {
			try moc.save()
		} catch {
			print(error.localizedDescription)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerMainView()
    }
}
