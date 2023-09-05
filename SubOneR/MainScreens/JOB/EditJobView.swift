//
//  EditJobView.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/23/23.
//

import SwiftUI

struct EditJobView: View {
	
	@Environment(\.managedObjectContext) var moc
	@Environment(\.dismiss) var dismiss
	var customer: FetchedResults<Customer>.Element
	
	@State private var invoice = ""
	
    var body: some View {
		Form {
			TextField("\(customer.name!)", text: $invoice)
			
		}
    }
}
//
//struct EditJobView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditJobView()
//    }
//}
