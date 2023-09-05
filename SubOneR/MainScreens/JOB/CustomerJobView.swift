//
//  JobView.swift
//  SubOneR
//
//  Created by Ben Huggins on 6/30/23.
//

import SwiftUI
import CoreData

struct CustomerJobView: View {
	
	var customer: Customer
	
//	@FetchRequest(sortDescriptors: [], predicate:  NSPredicate(format: "name = %@ && jobCurrentStatus = %@", "Quote", customer.name) var jobs: FetchedResults<Job>
//
//				  NSPredicate(format: "name = %@ && jobCurrentStatus = %@", "Quote", customer.name)
				  
//	let jobs = customer.job.jobCurrentStatus.filter {$0.jobCurrentStatus == "Job"}.first
	
	
	
	
//	let request = NSFetchRequest(entityName: "SubOneR")
//	let predicate = NSPredicate(format: "name == %@ && jobCurrentStatus == %@", "Job", customer.unwrappedNameJob)
// request.predicate = predicate
				  
	@State private var showAddJobView = false
	@Environment(\.managedObjectContext) var moc
	@State private var addTodayTaskToggle = false
	@State private var addCheck = false
	
	let jobStatusSelection = ["Quote", "Job"]
	
//	let jobOne: [Job]
	
//	for n in customer.jobArray {
//		if n.jobCurrentStatus == "Job" {
//			jobOne.append(n)
//		}
//	}
//
	
	
    var body: some View {
		
		var jobTwo = customer.jobArray.filter {$0.jobCurrentStatus == "Job"}   // Filter by "Job"
		
		List {
			ForEach(jobTwo, id: \.self) { job in
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
			AddJobView(customer: customer)          // In order to add a job we must pass it the singer
		}
	
    }
//
//	func updateJobs() {
//		print("updateJobs")
//
//
//	}
	
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
