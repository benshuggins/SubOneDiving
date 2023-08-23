//
//  JobView.swift
//  SubOneR
//
//  Created by Ben Huggins on 6/30/23.
//

import SwiftUI
import CoreData

struct CustomerJobView: View {
	
	let customer: Customer
	
	@State private var showAddJobView = false
	@Environment(\.managedObjectContext) var moc
	@State private var addTodayTaskToggle = false
	@State private var addCheck = false
	
	
	
    var body: some View {
		List {
			ForEach(customer.jobArray, id: \.self) { job in
				NavigationLink {
					JobViewDetail(job: job)
				} label: {
				
					VStack(alignment: .leading) {
						
						EmojiStatusView(rating: job.status)
					
							VStack(alignment: .leading) {
								Text("Invoice #: \(job.invoice)")
								Text(job.nameJob ?? "")
								Text("Job Status:  \(job.jobCurrentStatus ?? "")" )  
								Text("Job Type: \(job.jobType ?? "")")
								
								if let startDate = job.startDate {
									Text("StartDate: \(startDate.formatted(date: .abbreviated, time: .omitted))")
								}
								if let endDate = job.endDate {
									Text("Completion Date: \(endDate.formatted(date: .abbreviated, time: .omitted))")
								}
								Toggle("Add to Today's Task", isOn: $addCheck)
									.toggleStyle(.switch)
						}
					}
				}
			}
			.onDelete(perform: deleteJobs)
			
		}
		.navigationTitle("\(customer.wrappedName) Jobs")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()									
				}
				ToolbarItem() {
					Button {
						showAddJobView.toggle()
					} label: {
						Label("Add Job", systemImage: "plus")
					}
				}
			}
			.sheet(isPresented: $showAddJobView) {
				AddJobView(customer: customer)
			}
		
    }
	
	func updateJobs() {
		print("updateJobs")
		
	
	}
	
	// Delete a job tied to a customer
	func deleteJobs(at offsets: IndexSet) {
		for offset in offsets {
			// find this book in our fetch request
			let customerJob = customer.jobArray[offset]

			// delete it from the context
			moc.delete(customerJob)
		}

		// save the context
		try? moc.save()
	}
		
	
}

//struct JobView_Previews: PreviewProvider {
//    static var previews: some View {
//		//JobView(customer: customer.jobArray)
//    }
//}
