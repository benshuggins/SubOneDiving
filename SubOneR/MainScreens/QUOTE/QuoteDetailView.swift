//
//  QuoteDetailView.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/15/23.
//

// This has a list of created Quotes and allows you to store created Quotes that will become a job

import SwiftUI

struct QuoteDetailView: View {
	
	let customer: Customer
	
	@Environment(\.managedObjectContext) var moc
	
	@State private var showAddQuoteView = false
	@State private var needsRefresh: Bool = false
	
	var body: some View {
		List {
			ForEach(customer.jobArray, id: \.self) { job in
				NavigationLink {
					//JobViewDetail(job: job)                    // This gets sent to PDF
					PdfQuoteStartView(customer: customer)
				} label: {
					
					VStack(alignment: .leading) {
						
						EmojiStatusView(rating: job.status)
						
						VStack(alignment: .leading) {
							Text("Invoice #: \(job.invoice)")
							Text(job.nameJob ?? "")
							Text("Job Status:  \(job.status)")
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
		
		
		
//		
//		NavigationLink(destination: PdfQuoteStartView(customer: customer), isActive: $showingQuoteView) {
//			Button(action: {showingQuoteView = true}) {
//				Text("\(customer.wrappedName) Quotes")
//			}
//			.padding()
//			.background(.blue)
//			.accentColor(.white)
//			.cornerRadius(22)
//			
//		}
		.listStyle(PlainListStyle())
		.accentColor(needsRefresh ? .white : .black)
		.navigationTitle("\(customer.wrappedName) Quotes")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			
			ToolbarItem() {
				Button {
					showAddQuoteView.toggle()
				} label: {
					Label("Add Job", systemImage: "plus")
				}
			}
		}
		.sheet(isPresented: $showAddQuoteView) {
			AddQuoteView(customer: customer, needsRefresh: $needsRefresh)
		}
		
	}
}
//struct QuoteDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteDetailView()
//    }
//}
