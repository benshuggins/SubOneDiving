//
//  AddCustomerView.swift
//  SubOneR
//
//  Created by Ben Huggins on 6/28/23.
//

import SwiftUI
import CoreData

struct AddCustomerView: View {
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.managedObjectContext) var moc
	let vesselTypes = ["small sail", "motorboat", "yacht"]
	
	@State private var name = ""
	@State private var rating = 3
	@State private var marina = ""
	@State private var vesselType = ""
	@State private var customerDes = ""
	@State private var slip = ""
	@State private var gate = ""
	
	@Binding var needsRefresh: Bool   // This is the refresh hack 
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Customer", text: $name)
					TextField("Marina", text: $marina)
					
				}
				Section {
					TextField("Slip #", text: $slip)
					TextField("Gate #", text: $gate)
					
					
					Picker("Boat Type", selection: $vesselType) {
						ForEach(vesselTypes, id: \.self) {
							Text($0)
						}
					}
				}
				Section {
					TextEditor(text: $customerDes)
					//RatingView(rating: $rating)
				} header: {
					Text("Add customer Information")
				}
				
				Section {
					Button("Save") {
						// add the book
						needsRefresh.toggle()
						DataController().addCustomer(name: name, marina: marina, customerDes: customerDes, slip: slip, vesselType: vesselType, moc: moc)

							
						dismiss()
					}
					 .disabled(name.isEmpty)
				}
			}
			.navigationTitle("Add a SubOne Client")
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}
//
//struct AddCustomerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCustomerView()
//    }
//}
