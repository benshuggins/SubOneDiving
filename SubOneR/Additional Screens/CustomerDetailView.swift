//
//  CustomerDetailView.swift
//  SubOneR
//
//  Created by Ben Huggins on 6/28/23.
//

import SwiftUI
import CoreData
import PhotosUI

struct CustomerDetailView: View {
	
	@Environment(\.managedObjectContext) private var moc
	@Environment(\.dismiss) var dismiss
	@State private var showingDeleteAlert = false
	@State private var showingJobView = false 
	@State private var showingQuoteView = false
	
	@State private var showEditCustomerView = false
	
	
	@State var selectedItems: [PhotosPickerItem] = []
	@State var data: Data?
	
	let customer: Customer
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 30) {
				//Text(customer.name ?? "")
				Text("Marina:  \(customer.wrappedMarina)")
				
				Text("Slip: \(customer.wrappedSlip)")
				
				Text("Gate: \(customer.wrappedGate)")
				
				if let date = customer.dateJoined {
					Text("Date Joined: \(date.formatted(date: .abbreviated, time: .omitted))")
				}
				Text("Customer Notes: \(customer.wrappedCustomerDesc)")
				
				VStack {
					if let data = data, let uiimage = UIImage(data: data) {
						Image(uiImage: uiimage)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.scaledToFit()
							.padding(.top, 15)
					}
						Spacer()
						PhotosPicker(selection: $selectedItems, matching: .images) {
							Text("Add Image of Customer's Boat")
							
						}
						.onChange(of: selectedItems) { newValue in
							guard let item = selectedItems.first else { return
								
							}
							item.loadTransferable(type: Data.self) { result in
								switch result {
									case .success(let data):
										if let data = data {
											self.data = data
										} else {
											print("failed to load data is nil")
										}
									case .failure(let failure):
										fatalError("\(failure)")
								}
								
							}
						}
					}
				}
			}
		NavigationLink(destination: CustomerJobView(customer: customer), isActive: $showingQuoteView) {
			Button(action: {showingJobView = true}) {
				Text("Create Quote For: \(customer.wrappedName)")
			}
				.padding()
				.background(.blue)
				.accentColor(.white)
				.cornerRadius(22)
			
		}
		
		NavigationLink(destination: CustomerJobView(customer: customer), isActive: $showingJobView) {
			Button(action: {showingJobView = true}) {
				Text("Go to \(customer.wrappedName) Job's")
			}
				.padding()
				.background(.blue)
				.accentColor(.white)
				.cornerRadius(22)
			
		}
		.navigationTitle("\(customer.wrappedName) Info")
		.navigationBarTitleDisplayMode(.inline)
		
		
		.alert("Delete Customer: \(customer.wrappedName)? ", isPresented: $showingDeleteAlert) {
			Button("Delete", role: .destructive, action: deleteBook)
			Button("Cancel", role: .cancel) { }
		} message: {
			Text("Are you sure?")
		}
		.toolbar {
			ToolbarItemGroup(placement: .navigationBarTrailing) {
				Button {
					showingDeleteAlert = true
				} label: {
					Label("Delete this book", systemImage: "trash")
				}
			}
		}
		.toolbar {
			ToolbarItemGroup(placement: .navigationBarTrailing) {
				Button {
					showEditCustomerView = true
				} label: {
					Label("Edit This Book", systemImage: "person.2.badge.gearshape.fill")
				}
			}
			
			
			
		}
			.sheet(isPresented: $showEditCustomerView) {
				EditCustomerView(customer: customer)
			}

    }
	
	func deleteBook() {
		moc.delete(customer)
		
		try? moc.save()
		
		dismiss()
	}
}

//struct ButtonView: View {
//var body: some View {
//	Text("\(customer.wrappedName)")
//		.frame(width: 200, height: 100, alignment: .center)
//		.background(Color.Blue)
//		.foregroundColor(Color.red)
//}
//}
//
//struct CustomerDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomerDetailView()
//    }
//}
