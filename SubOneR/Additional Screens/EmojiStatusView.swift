//
//  EmojiStatusView.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/11/23.
//

import SwiftUI

struct EmojiStatusView: View {
	let rating: Int16

	   var body: some View {
		   switch rating {
		   case 1:
			   Text("Q👺uote Sent")
		   case 2:
			   Text("Quote Payment Recieved")
		   case 3:
			   Text("Job Started")
		   case 4:
			   Text("Job Payement Not Revieved")
		   default:
			   Text("👹")
		   }
	   }
}

struct EmojiStatusView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiStatusView(rating: 3)
    }
}
