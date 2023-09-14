//
//  EditCustomerView.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/12/23.
//

import SwiftUI

struct EditCustomerView: View {
	
	@Environment(\.managedObjectContext) var moc
	@Environment(\.dismiss) var dismiss
	
	//var customer: FetchedResults<Customer>.Element
	
	@ObservedObject var customer: Customer
	
	@State private var name = ""
	//@State private var rating = 3
	@State private var marina = ""
	//@State private var vesselType = ""
	@State private var customerDes = ""
	@State private var slip = ""
	@State private var gate = ""
	
    var body: some View {
		Form {
			TextField("Name: \(customer.name!)", text: $name)
			TextField("Marina: \(customer.marina!)", text: $marina)
			//TextField("\(customer.vesselType!)", text: $vesselType)
			TextField("Description \(customer.customerDes!)", text: $customerDes)
			TextField("Slip \(customer.slip!)", text: $slip)
		//	TextField("\(customer.gate!)" , text: $gate)
			
				.onAppear {
					name = customer.name!
					marina = customer.marina!
					//vesselType = customer.vesselType!
					customerDes = customer.customerDes!
					slip = customer.slip!
					//gate = customer.gate!
				}
			
			HStack {
				Spacer()
				Button("Submit") {
					
					DataController().editCustomer(customer: customer, name: name, slip: slip, marina: marina, gate: gate, customerDes: customerDes, moc: moc)
					
					
			
					dismiss()
				}
				Spacer()
			}
		}
		.navigationTitle("Edit \(name)")
	}
}

//struct EditCustomerView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCustomerView()
//    }
//}
