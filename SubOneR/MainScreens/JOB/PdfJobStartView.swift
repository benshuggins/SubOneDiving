//
//  PdfJobStartView.swift
//  SubOneR
//
//  Created by Ben Huggins on 9/7/23.
//


// Just add something to job

import SwiftUI

struct PdfJobStartView: View {
	
	@Environment(\.managedObjectContext) var moc // have access to the moc
	@Environment(\.dismiss) var dismiss
		
	@ObservedObject var customer: Customer // I just took data from the customer
	@ObservedObject var job: Job   // I just pass it a Job and wa la
		
	@State private var quoteNumber = ""
	@State private var quoteDate = Date.now
	@State private var quoteDescription = ""
	@State private var vessel: String = ""
	@State private var amount = 0
	@State private var locationVessel = ""
	
	let jobStatusSelection = ["Quote", "Job"]
	@State private var jobCurrentStatus = "Quote"

 var body: some View {
	 
		VStack {
		  formJob()
		  buttonsJob()
		  Spacer()
	   }
	  .navigationTitle(Text("Create Inspection Report"))
	  .navigationBarTitleDisplayMode(.inline)
	}
}


//struct PdfJobStartView_Previews: PreviewProvider {
//    static var previews: some View {
//        PdfJobStartView()
//    }
//}



extension PdfJobStartView {
	public func formJob() -> some View {
		Form {
			Text(customer.wrappedName)
			
			TextField("Location/ Vessel", text: $vessel)
			
			Text(customer.wrappedGate)
			
		//	TextField("Quote #", text: $quote.quoteNumber)
			
			TextField("Invoice #", text: $quoteNumber)     // Here I update the invoice
			
			TextField("\(quoteDate)", value: $quoteDate, format: .dateTime)
			
			TextField("Description: ", text: $quoteDescription, axis: .vertical)
				.textFieldStyle(.roundedBorder)
			
		//	TextField("Amount: ", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//
//			TextField("Amount: \(job.amount)", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//
			Text("Amount: \(job.amount)")
			TextField("\(job.amount)", value: $amount, format: .number )
			
			
			// Why doesn't the status change ??
			Section {
				Picker("Quote Status", selection: $jobCurrentStatus) {
					Text("").tag("") //basically added empty tag and it solve the case
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
extension PdfJobStartView {
	private func buttonsJob() -> some View {
	   
		HStack(spacing : 20) {
			NavigationLink(destination : PdfPreviewIRView(customer: customer, job: job) ){   // Here I pass in both the new quote and the customer
				
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
		// Need to make a new function
	
		DataController().updateQuote(customer: customer, job: job, jobCurrentStatus: jobCurrentStatus, amount: amount, quoteNumber: quoteNumber, moc: moc)
			dismiss()
		
		
		
	}
}
