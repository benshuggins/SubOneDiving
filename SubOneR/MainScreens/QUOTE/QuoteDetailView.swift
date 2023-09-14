//
//  QuoteDetailView.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/15/23.
// This has a list of created Quotes and allows you to store created Quotes that will become a job

import SwiftUI

struct QuoteDetailView: View {
	
	let customer: Customer
	
	@Environment(\.managedObjectContext) var moc
	
	@State private var showAddQuoteView = false
	@State private var needsRefresh: Bool = false
	
	var body: some View {
		
		var quoteTwo = customer.jobArray.filter {$0.jobCurrentStatus == "Quote"}   // Filter by "Quote"
		
		List {
			ForEach(quoteTwo, id: \.self) { job in
				NavigationLink {
					//JobViewDetail(job: job)                    // This gets sent to PDF
					PdfQuoteStartViewQuote(customer: customer, job: job)        // send in the customer and the job
				} label: {
					
					VStack(alignment: .leading) {
						
				//		EmojiStatusView(rating: job.status)
						
						VStack(alignment: .leading) {
							Text("Invoice #: \(job.invoice)")
							Text(job.nameJob ?? "")
						//	Text("Job Status:  \(job.status)")
							
						//	Text(job.jobCurrentStatus ?? "")
							
							Text("Status: \(job.jobCurrentStatus ?? "")")
							
							Text("Job Type: \(job.jobType ?? "")")
							
							if let startDate = job.startDate {
								Text("StartDate: \(startDate.formatted(date: .abbreviated, time: .omitted))")
							}
							if let endDate = job.endDate {
								Text("Completion Date: \(endDate.formatted(date: .abbreviated, time: .omitted))")
							}
//							Toggle("Add to Today's Task", isOn: $addCheck)
//								.toggleStyle(.switch)
						}
					}
				}
			}
			//.onDelete(perform: deleteJobs)
			
		}
		.listStyle(PlainListStyle())
		.accentColor(needsRefresh ? .white : .black)
		.navigationTitle("\(customer.wrappedName) Quotes")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			
			ToolbarItem(placement: .primaryAction) {
				Button {
					showAddQuoteView.toggle()
				} label: {
					Label("Add Job", systemImage: "plus")
				}
			}
		}
		.sheet(isPresented: $showAddQuoteView) {
			AddQuoteView(customer: customer, needsRefresh: $needsRefresh)     // need to pass needsRefresh and the first data object 
		}
		
	}
}
//struct QuoteDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteDetailView()
//    }
//}
