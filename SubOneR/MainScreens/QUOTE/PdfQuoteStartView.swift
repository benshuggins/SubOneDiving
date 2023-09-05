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

// Here I am creating a new Quote and passing that 
struct Quote {
	
	 var quoteNumber = ""
	 var quoteDate = Date.now
	 var quoteDescription = ""
	 var vessel: String = ""
	 var cost = 0
	 var locationVessel = ""
}


struct PdfQuoteStartView: View {
	
	@Environment(\.managedObjectContext) var moc // have access to the moc
		
	let customer: Customer // I just took data from the customer
	
	let job: Job   // I just pass it a Job and wa la
	
	@State private var quote = Quote()     // instantiate a new quote, this needs to be removed. How does update work. 
	
	@State private var quoteNumber = ""
	@State private var quoteDate = Date.now
	@State private var quoteDescription = ""
	@State private var vessel: String = ""
	@State private var cost = 0
	@State private var locationVessel = ""
	
	@State private var makeJobToggle = false
	
	let jobStatusSelection = ["Quote", "Job"]

	@State private var jobCurrentStatus = ""

 var body: some View {
	 
		VStack {
		  form()        
		  buttons()
		  Spacer()
	   }
	  .navigationTitle(Text("Edit Quote"))
	}
}

//struct PdfQuoteStartView_Previews: PreviewProvider {
//    static var previews: some View {
//		PdfQuoteStartView()
//    }
//}


// This is where it is created and sent from
extension PdfQuoteStartView {
	public func form() -> some View {
		Form {
			Text(customer.wrappedName)     //
			
			TextField("Location/ Vessel", text: $vessel)
			
			Text(customer.wrappedGate)
			
		//	TextField("Quote #", text: $quote.quoteNumber)
			
			TextField("Invoice #", text: $quoteNumber)     // Here I update the invoice
			
			TextField("\(quote.quoteDate)", value: $quote.quoteDate, format: .dateTime)
			
			
			TextField("Description: ", text: $quote.quoteDescription, axis: .vertical)
				.textFieldStyle(.roundedBorder)
			
			TextField("Amount", value: $quote.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
			
			Section {
				Picker("Quote Status", selection: $jobCurrentStatus) {
					ForEach(jobStatusSelection, id: \.self) {
						Text($0)
					}
				}
			}
			
		}
		.padding(4)
	}
}
// I am passing Customer 
extension PdfQuoteStartView{
	private func buttons() -> some View {
	   
		HStack(spacing : 20) {
			NavigationLink(destination : PdfPreviewView(customer: customer, quote: quote) ){   // Here I pass in both the new quote and the customer 
				
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
			
			
			// This saves the
			Button(action: { updateJob() }, label: {
				Text("Update")
				.padding(10)
				.frame(width: 100)
				.background(Color.red)
				.foregroundColor(.white)
				.cornerRadius(20)
			})
		}
	}
	
	func updateJob() {
	
		DataController().editJob(customer: customer, job: job, jobCurrentStatus: jobCurrentStatus, quoteNumber: quoteNumber, moc: moc)
			//dismiss()
		
	}
}
