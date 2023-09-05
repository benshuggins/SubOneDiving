//
//  JobViewDetail.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/3/23.
//

import SwiftUI
import PhotosUI

// having pre entered images into assets would really help

struct JobViewDetail: View {
	
	@State var selectedItems: [PhotosPickerItem] = []
	@State var data: Data?
	
	let job: Job
	
	@State private var brownAlgaeColor = 0
	@State private var greenAlgaeColor = 0
	@State private var blackAlgae = 0
	@State private var tunicatesSponge = 0
	@State private var barnacles = 0
	@State private var oysters = 0
	//	@State private var mussels = 0
	//	@State private var coralWorms = 0
	
	@State private var addCheck = false
	
	
	@State private var anodeMaterialLeft: Double = 0
	
	@Environment(\.openURL) var openURL
	@State private var askForAttachment = false
	@State private var showEmail = false
	@State private var email = SupportEmail(toAddress: "benshuggins@gmail.com",
									 subject: "Support Email",
									 messageHeader: "SubOne Data Encoder Needed Customers -> JSON -> Email")
	
	var body: some View {
			Form {
				Section("Add Invoice") {
					Toggle("Add Invoice", isOn: $addCheck)
						.toggleStyle(.switch)
				}
				Section("Anodes") {
					Slider(value: $anodeMaterialLeft, in: -100...100)
								Text("Anode: \(anodeMaterialLeft, specifier: "%.1f") Anode metal Left is \(anodeMaterialLeft, specifier: "%.1f") percent")
				}
			.headerProminence(.increased)
				}
		
		ScrollView {
			VStack {
				if let data = data, let uiimage = UIImage(data: data) {
					Image(uiImage: uiimage)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.scaledToFit()
						.padding(.top, 15)
				}
					Spacer()
					PhotosPicker(selection: $selectedItems, matching: .images) {
						Text("Add Image of Growth - Hull - WaterLine")
						
					}
					.onChange(of: selectedItems) { newValue in
						guard let item = selectedItems.first else { return
							
						}
						item.loadTransferable(type: Data.self) { result in
							switch result {
								case .success(let data):
									if let data = data {
										self.data = data
									} else {
										print("failed to load data is nil")
									}
								case .failure(let failure):
									fatalError("\(failure)")
							}
						}
					}
				}
			
				Section("Growth- Hull - Waterline") {
					VStack {
						Text("Brown Algae")
						Picker("Hull Brown Algae?", selection: $brownAlgaeColor) {
							Text("Nothing").tag(1)
							Text("Light").tag(2)
							Text("Moderate").tag(3)
							Text("Heavy").tag(4)
							Text("Extreme").tag(5)
						}
						.pickerStyle(.segmented)
						
						Text("Green Algae")
						
						Picker("Green Algae?", selection: $greenAlgaeColor) {
							Text("Nothing").tag(1)
							Text("Light").tag(2)
							Text("Moderate").tag(3)
							Text("Heavy").tag(4)
							Text("Extreme").tag(5)
						}
						.pickerStyle(.segmented)
						
						Text("Black Algae")
						
						Picker("Black Algae?", selection: $blackAlgae) {
							Text("Nothing").tag(1)
							Text("Light").tag(2)
							Text("Moderate").tag(3)
							Text("Heavy").tag(4)
							Text("Extreme").tag(5)
						}
						.pickerStyle(.segmented)
						
						Text("Tunicates/ Sponge")
						
						Picker("Tunicates/Sponge?", selection: $tunicatesSponge) {
							Text("Nothing").tag(1)
							Text("Light").tag(2)
							Text("Moderate").tag(3)
							Text("Heavy").tag(4)
							Text("Extreme").tag(5)
						}
						.pickerStyle(.segmented)
						
						Text("Barnacles")
						
						Picker("Barnacles", selection: $barnacles) {
							Text("Nothing").tag(1)
							Text("Light").tag(2)
							Text("Moderate").tag(3)
							Text("Heavy").tag(4)
							Text("Extreme").tag(5)
						}
					}
					.pickerStyle(.segmented)
					}
				}
			.navigationTitle("\(job.unwrappedNameJob), \(job.invoice)")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						askForAttachment.toggle()
					} label: {
						HStack {
							Text("Email Support")
							Image(systemName: "envelope.circle.fill")
								.font(.title2)
						}
					}
				}
			}
			.sheet(isPresented: $showEmail) {
				MailView(supportEmail: $email) { result in
					switch result {
					case .success:
						print("Email sent")
					case .failure(let error):
						print(error.localizedDescription)
					}
				}
			}
			.confirmationDialog("", isPresented: $askForAttachment) {
				Button("Yes") {
					email.data = ExampleData.data
					if email.data == nil {
						email.send(openURL: openURL)
					} else {
						if MailView.canSendMail {
							showEmail.toggle()
						} else {
							print("""
							This device does not support email
							\(email.body)
							"""
							)
						}
					}
				}
				Button("No") {
					email.send(openURL: openURL)
				}
			} message: {
				Text("""
				SUPPORT EMAIL
				Include data as an attachment?
				""")
				}
			}
		}
		
	


//struct JobViewDetail_Previews: PreviewProvider {
//	static var previews: some View {
//		NavigationView {
//			JobViewDetail(job: job)
//		}
//
//	}
//}
