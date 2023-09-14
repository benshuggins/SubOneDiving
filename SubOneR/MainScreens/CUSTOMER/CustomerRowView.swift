//
//  CustomerRowView.swift
//  SubOneR
//
//  Created by Ben Huggins on 9/8/23.
//

import SwiftUI

struct CustomerRowView: View {
	
	let customer: Customer
	
    var body: some View {
		
		VStack(alignment: .leading) {
			Text(customer.wrappedName)
				.font(.system(size: 20, design: .rounded).bold())
				
			Text(customer.wrappedMarina) // why arent default values showing up?
				.font(.callout.bold())
			}
    }
}

//struct CustomerRowView_Previews: PreviewProvider {
//    static var previews: some View {
//		CustomerRowView(customer: customer)
//    }
//}
