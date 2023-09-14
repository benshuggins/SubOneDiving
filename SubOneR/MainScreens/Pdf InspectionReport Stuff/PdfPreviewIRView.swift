//
//  PdfPreviewIRView.swift
//  SubOneR
//
//  Created by Ben Huggins on 9/8/23.
//

import Foundation
import SwiftUI

struct PdfPreviewIRView: View {
	
	@Environment(\.managedObjectContext) var moc
//	@State private var showShareSheet2 : Bool = false
	
	@State private var showShareSheet: Bool = false
	
	let customer: Customer
	let job: Job
	
	var body: some View {
		
		VStack {
			PdfViewUI(data: pdfData())
			shareButton()
			Spacer()
		}
		.navigationTitle(Text("Preview"))
		.navigationBarTitleDisplayMode(.inline)
		
		.sheet(isPresented: $showShareSheet, content: {
			if let data = pdfData() {
				ShareView(activityItems: [data])
			}
		})
	}
	
	// This converts to data which is then sent to the PDFViewUI() above
	func pdfData() -> Data? {
		
		return PdfCreatorIR().pdfData(title: customer.wrappedName, body: customer.wrappedMarina, job: job)  // Here I can just pass in the job
	}
}

//struct PdfPreviewIRView_Previews: PreviewProvider {
//    static var previews: some View {
//        PdfPreviewIRView()
//    }
//}



extension PdfPreviewIRView {
	 func shareButton() -> some View {
	
		Button(action: {
			self.showShareSheet.toggle()
		}, label: {
			Text("Save Send")
			.padding(10)
			.frame(width: 100)
			.background(Color.blue)
			.foregroundColor(.white)
			.cornerRadius(20)
		})
	}
}
