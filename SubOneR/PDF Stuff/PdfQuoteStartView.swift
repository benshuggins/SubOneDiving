//
//  QuoteView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/7/23.
//

import SwiftUI


struct MultilineTextFieldDescription: View {
	//@State private var description = ""
	@State private var quote = Quote()
	var body: some View {
		TextField("Description", text: $quote.quoteDescription, axis: .vertical)
			.textFieldStyle(.roundedBorder)
	}
}

struct Quote {
	
	 var quoteNumber = ""
	 var quoteDate = Date.now
	 var quoteDescription = ""
	 var vessel: String = ""
	 var cost = 0
	 var locationVessel = ""
	
}


struct PdfQuoteStartView: View {
		
let customer: Customer
	@State private var quote = Quote()
	
//	@State private var quoteNumber = ""
//	@State private var quoteDate = Date.now
//	@State private var quoteDescription = ""
//	@State private var vessel: String = ""
//	@State private var cost = 0
//	@State private var locationVessel = ""

 var body: some View {
	 
		VStack {
		  form()        
		  buttons()
		  Spacer()
	   }
	  .navigationTitle(Text("Create Quote"))
	}
}

//struct PdfQuoteStartView_Previews: PreviewProvider {
//    static var previews: some View {
//		PdfQuoteStartView()
//    }
//}


// This is where it is created and sent from
extension PdfQuoteStartView {
	private func form() -> some View {
		Form {
			Text(customer.wrappedName)
			
			TextField("Location/ Vessel", text: $quote.locationVessel)
			
			Text(customer.wrappedGate)
			
			TextField("Quote #", text: $quote.quoteNumber)
			
			TextField("\(quote.quoteDate)", value: $quote.quoteDate, format: .dateTime)
			
			Text("Description")
			
			TextField("Description: ", text: $quote.quoteDescription, axis: .vertical)
				.textFieldStyle(.roundedBorder)
			
			TextField("Amount", value: $quote.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
			
		}
		.padding(4)
	}
}
// I am passing Customer 
extension PdfQuoteStartView{
	private func buttons() -> some View {
	   
		HStack(spacing : 50) {
			NavigationLink(destination : PdfPreviewView(customer: customer, quote: quote) ){
				Text("Preview")
				.padding(10)
				.frame(width: 100)
				.background(Color.blue)
				.foregroundColor(.white)
				.cornerRadius(20)
			}

			Button(action: {  }, label: {
				Text("Clear")
				.padding(10)
				.frame(width: 100)
				.background(Color.red)
				.foregroundColor(.white)
				.cornerRadius(20)
			})
		}
	}
}
