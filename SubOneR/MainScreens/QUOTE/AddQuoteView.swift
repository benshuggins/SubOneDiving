//
//  AddQuoteView.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/15/23.
//

import SwiftUI

struct AddQuoteView: View {
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.managedObjectContext) var moc
	@ObservedObject var customer: Customer
	let jobTypes = ["Hull Cleaning w/o Anode change", "Hull cleaning with Anode change","Anode Change", "Dock Maintenance", "Marina Maintenace", "Propeller Work", "Salvage", "General", "Other", "Popeller Untangle", "Inspection"]
	let jobStatusSelection = ["Quote", "Job"]
	let date = Date.now
	
	@State private var jobName = ""
	@State private var jobType = ""
	@State private var invoice = ""
	@State private var startDate = Date.now
	@State private var completionDate = Date.now
	@State private var status = 1                      // A Quote is status 1
	@State private var jobStatus = ""
	@State private var jobCurrentStatus = "Quote"   // This starts life as a Quote
	
	@Binding var needsRefresh: Bool
	
	// Adds up all previous invoices and gives you a recommended invoice count
	var invoiceCount: Int {
		return customer.jobArray.count
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					//					TextField("\(customer.wrappedName) ", text: $jobName)
					//						.textFieldStyle(.roundedBorder)
					Text("Name: \(customer.wrappedName)")
					
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
					
					Text("Job Status: \(jobCurrentStatus)")   // This is set on quote
					
					//				Picker("Quote Status", selection: $currentJobStatus) {
					//					ForEach(jobStatusSelection, id: \.self) {
					//						Text($0)
					//					}
				}
				
				Section {
					Button("Save") {
						
						needsRefresh.toggle()
						
						let job1 = Job(context: moc)
						job1.nameJob = customer.wrappedName
						job1.invoice = Int16(invoice) ?? 0
						job1.jobType = jobType
						job1.startDate = startDate
						job1.endDate = completionDate
						job1.origin = customer //  Customer(context: moc) // attach to customer
						job1.status = Int16(status)
						job1.jobCurrentStatus = jobCurrentStatus
						
						try? moc.save()
						
						//					 Instance member 'createNewJob' cannot be used on type 'DataController'; did you mean to use a value of this type instead?
						
						dismiss()
					}
				}
			}
			.navigationTitle("Add Quote")
		}
	}
	
}

