//
//  AddJobView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/3/23.
//

import SwiftUI
import CoreData

struct AddJobView: View {
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.managedObjectContext) var moc
	let customer: Customer
	let jobTypes = ["Hull Cleaning w/o Anode change", "Hull cleaning with Anode change","Anode Change", "Dock Maintenance", "Marina Maintenace", "Propeller Work", "Salvage", "General", "Other", "Popeller Untangle", "Inspection"]
	let jobStatusSelection = ["Quote no Payment", "Quote Payment Recieved", "Make Job", "Job Finished", "Payment Recieved"]
	let date = Date.now
	
	@State private var jobName = ""
	@State private var jobType = ""
	@State private var invoice = ""
	@State private var startDate = Date.now
	@State private var completionDate = Date.now
	@State private var status = 1                      // A Quote is status 1
	@State private var jobStatus = ""
	@State private var currentJobStatus = ""

	// Adds up all previous invoices and gives you a recommended invoice count
	var invoiceCount: Int {
		return customer.jobArray.count
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Job Name: ", text: $jobName)
						.textFieldStyle(.roundedBorder)
					TextField("Invoice #:\(invoiceCount) ", text: $invoice)
						.textFieldStyle(.roundedBorder)
				}
				Section {
					
					DatePicker(selection: $startDate, in: Date.now..., displayedComponents: .date) {
						Text("Select a start date")
					}
					
				}
				Section {
					// End date needs to notify the user if not completed .
					DatePicker(selection: $completionDate, in: Date.now..., displayedComponents: .date) {
						Text("Select a completion date")
					}
				}
				Section {
					Picker("Job Type", selection: $jobType) {
						ForEach(jobTypes, id: \.self) {
							Text($0)
						}
					}
				}
				Section {
					Picker("Job Status", selection: $currentJobStatus) {
						ForEach(jobStatusSelection, id: \.self) {
							Text($0)
						}
					}
				}
			}
				}
		Section {
			Button("Save") {
				
				let job1 = Job(context: moc)
				job1.nameJob = jobName
				job1.invoice = Int16(invoice) ?? 0
				job1.jobType = jobType
				job1.startDate = startDate
				job1.endDate = completionDate
				job1.origin = customer //  Customer(context: moc) // attach to customer
				job1.status = Int16(status)
				
				
				try? moc.save()
				
				dismiss()
			}
		}
					.navigationTitle("Add Job")
			}
	}
		

	



//
//struct AddJobView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddJobView()
//    }
//}
