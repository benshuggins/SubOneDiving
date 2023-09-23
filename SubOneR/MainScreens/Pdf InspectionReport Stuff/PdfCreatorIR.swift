//
//  PdfCreatorInspection.swift
//  SubOneR
//
//  Created by Ben Huggins on 9/8/23.
//  INSPECTION REPORT 

import Foundation
import PDFKit


// Default title and Body creator
class PdfCreatorIR : NSObject {
	private var pageRect : CGRect
	private var renderer : UIGraphicsPDFRenderer?

	let subOneMainLogo = UIImage(named: "SubOneMain")
	let boatDiagram = UIImage(named: "BoatDiagram")
	/**
	W: 8.5 inches * 72 DPI = 612 points
	H: 11 inches * 72 DPI = 792 points
	A4 = [W x H] 595 x 842 points
	*/
	init(pageRect : CGRect =
		CGRect(x: 0, y: 0, width: (8.5 * 72.0), height: (11 * 72.0))) {
	   
		let format = UIGraphicsPDFRendererFormat()

		let metaData = [kCGPDFContextTitle: "It's a PDF!",
			kCGPDFContextAuthor: "TechChee"]

		format.documentInfo = metaData as [String: Any]
		self.pageRect = pageRect
		self.renderer = UIGraphicsPDFRenderer(bounds: self.pageRect,
											 format: format)
		super.init()
	}
}

// This draws the PDF
extension PdfCreatorIR {
	
	// LEFT SIDE
	private func addSubOneLogo(pageRect: CGRect, imageTop: CGFloat, image: UIImage) -> CGFloat {
		// 1
		let maxHeight = pageRect.height * 0.20   ///0.10
		let maxWidth = pageRect.width * 0.25	// 0.25
		// 2
		let aspectWidth = maxWidth / image.size.width
		let aspectHeight = maxHeight / image.size.height
		let aspectRatio = min(aspectWidth, aspectHeight)
		// 3
		let scaledWidth = image.size.width * aspectRatio
		let scaledHeight = image.size.height * aspectRatio
		// 4
	 // let imageX = (pageRect.width - scaledWidth) / 4.0
		let imageRect = CGRect(x: 10, y: 20,
							 width: scaledWidth, height: scaledHeight)
		// 5
		image.draw(in: imageRect)
	
		return imageRect.origin.y + imageRect.size.height
	}
	
	private func addBoatDiagram(pageRect: CGRect, imageTop: CGFloat, image: UIImage) -> CGFloat {
		// 1
		let maxHeight = pageRect.height * 0.30   //0.10  This changes the height and width of the logo
		let maxWidth = pageRect.width * 0.30	// 0.25
		// 2
		let aspectWidth = maxWidth / image.size.width
		let aspectHeight = maxHeight / image.size.height
		let aspectRatio = min(aspectWidth, aspectHeight)
		// 3
		let scaledWidth = image.size.width * aspectRatio
		let scaledHeight = image.size.height * aspectRatio
		// 4
	 // let imageX = (pageRect.width - scaledWidth) / 4.0
		let imageRect = CGRect(x: 450, y: 90,
							 width: scaledWidth, height: scaledHeight)
		// 5
		image.draw(in: imageRect)
	
		return imageRect.origin.y + imageRect.size.height
	}
	
	private func addInspectionReportTitle (){
		let title = "Inspection Report"
		
		let textRect = CGRect(x: 180, y: 50, width: pageRect.width - 40 ,height: 33)
		title.draw(in: textRect, withAttributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .thin)])
	}
	
	// 1
	private func drawTopBeautyLine(_ drawContext: CGContext, pageRect: CGRect,
					  height: CGFloat) {
	  // 2
	  drawContext.saveGState()
	  // 3
	  drawContext.setLineWidth(2.0)

	  // 4  // draw line accross page
	  drawContext.move(to: CGPoint(x: 162, y: height))
	  drawContext.addLine(to: CGPoint(x: pageRect.width - 50, y: height))
	  drawContext.strokePath()
	  drawContext.restoreGState()

//	  // 5  draw dashed lines
//	  drawContext.saveGState()
//	  let dashLength = CGFloat(72.0 * 0.2)
//	  drawContext.setLineDash(phase: 0, lengths: [dashLength, dashLength])
//	  // 6
//	  let tabWidth = pageRect.width / CGFloat(numberTabs)
//	  for tearOffIndex in 1..<numberTabs {
//		// 7
//		let tabX = CGFloat(tearOffIndex) * tabWidth
//		drawContext.move(to: CGPoint(x: tabX, y: tearOffY))
//		drawContext.addLine(to: CGPoint(x: tabX, y: pageRect.height))
//		drawContext.strokePath()
//	  }
	  // 7
	  drawContext.restoreGState()
	}
	

	private func addSubOneContact () {
		
		let str2 = """
  SUB ONE DIVING INC
  +1 415-840-4666
  info@subonediving.com
  1784 SMITH AVE
  SAN JOSE, CA 95112
  """
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .justified
		
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.foregroundColor : UIColor.gray ]
		
		let bodyRect = CGRect(x: 25, y: 150, width: pageRect.width - 40 ,height: pageRect.height - 80)
		str2.draw(in: bodyRect, withAttributes: attributes)
	}
	
	
	// NAME
	private func addName(title: String){
		
		let name = "INSPECTION PREPARED FOR: \(title)"
		let textRect = CGRect(x: 175, y: 140, width: pageRect.width - 40 ,height: 40)
		name.draw(in: textRect, withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
	}
	
	// DATE			, set 15 points apart in y direction
	private func addQuoteDate(quoteDate: Date ){
		
		var quoteDate1 = ""
		let formatter2 = DateFormatter()
		formatter2.dateStyle = .medium
		quoteDate1 = formatter2.string(from: quoteDate)
		
		let quoteDate2 = "DATE PERFORMED: \(quoteDate1)"
		
		let attributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)]
			//NSAttributedString.Key.foregroundColor : UIColor.gray
		
		let textRect = CGRect(x: 175, y: 155, width: pageRect.width - 40 ,height: 40)
		quoteDate2.draw(in: textRect,
			  withAttributes: attributes)
	}
	
		// INVOICE #
	private func addQuoteNumber(quoteNumber : String) {
		
		let quoteNumber1 = "INVOICE #: \(quoteNumber)"
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .justified
		
		let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11),
			NSAttributedString.Key.paragraphStyle: paragraphStyle]
	
		let bodyRect = CGRect(x: 175, y: 170, width: pageRect.width - 40 ,height: pageRect.height - 80)
		quoteNumber1.draw(in: bodyRect, withAttributes: attributes)
	}
		
	// LOCATION
	private func addMarina(body : String) {
		let marina = "LOCATION: \(body)"
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .justified
		
		let attributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11),
			NSAttributedString.Key.paragraphStyle: paragraphStyle]

		let bodyRect = CGRect(x: 175, y: 185, width: pageRect.width - 40 ,height: pageRect.height - 80)
		marina.draw(in: bodyRect, withAttributes: attributes)
	}
	// Dive SuperVisor is N/A
	private func addDiveSupervisor() {
		
		let diveSuperVisor = "DIVE SUPERVISOR: N/A"
		let attributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)]
		let bodyRect = CGRect(x: 175, y: 200, width: pageRect.width - 40 ,height: pageRect.height - 80)
		diveSuperVisor.draw(in: bodyRect, withAttributes: attributes)
	}

		// ADD DIVER
	private func addDiver(diver: String) {
		
		let diveSuperVisor = "DIVER: \(diver) "
		let attributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)]
		let bodyRect = CGRect(x: 175, y: 215, width: pageRect.width - 40 ,height: pageRect.height - 80)
		diveSuperVisor.draw(in: bodyRect, withAttributes: attributes)
	}
	
	private func addVessel(vessel: String) {
		
		let vessel = "VESSEL: \(vessel) "
		let attributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)]
		let bodyRect = CGRect(x: 175, y: 230, width: pageRect.width - 40 ,height: pageRect.height - 80)
		vessel.draw(in: bodyRect, withAttributes: attributes)
	}

	
	private func addVesselType(vesselType: String) {
		
		let vesselType = "VESSEL: \(vesselType) "
		let attributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)]
		let bodyRect = CGRect(x: 175, y: 245, width: pageRect.width - 40 ,height: pageRect.height - 80)
		vesselType.draw(in: bodyRect, withAttributes: attributes)
	}
	
	
	private func lastHaulOut(haulOutDate: String) {
		
		let haulOutDate = "LAST HAUL-OUT DATE: \(haulOutDate)"
		let attributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)]
		let bodyRect = CGRect(x: 175, y: 260, width: pageRect.width - 40 ,height: pageRect.height - 80)
		haulOutDate.draw(in: bodyRect, withAttributes: attributes)
	}
	
	private func addHullTitle(){
		let title = "HULL"
		
		let textRect = CGRect(x: (pageRect.width/2)-40, y: 350, width: pageRect.width - 40 ,height: 33)
		title.draw(in: textRect, withAttributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)])
	}
	
	private func drawBeautyBoxTitles(_ drawContext: CGContext, pageRect: CGRect,
					  height: CGFloat) {
		
		guard let context = UIGraphicsGetCurrentContext() else { return }

		context.saveGState()
		defer { context.restoreGState() }
		
		let rect = CGRect(x: 10, y: 380, width: pageRect.width-40, height: 10)

		let path = UIBezierPath(
		  roundedRect: rect,
		  byRoundingCorners: [.topLeft, .topRight],
		  cornerRadii: CGSize(width: 4, height: 4)
		)

		context.setFillColor(UIColor.blue.cgColor)
		context.addPath(path.cgPath)
		context.closePath()
		context.fillPath()
		context.restoreGState()

	}
	private func addRunnningGearTitle(){
		let title = "RUNNING GEAR"
		
		let textRect = CGRect(x: (pageRect.width/2)-70, y: 550, width: pageRect.width - 40 ,height: 33)
		title.draw(in: textRect, withAttributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)])
	}
	
	
	
	
	
	
	
//
//	private func addInvoiceStaticText2 (){
//		let title = "Description"
//		let textRect = CGRect(x: 340, y: 400, width: pageRect.width - 40 ,height: 40)
//		title.draw(in: textRect, withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
//	}
//
//	private func addQuoteDescription(quoteDescription: String){
//
//		let attributes = [
//			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
//			//NSAttributedString.Key.paragraphStyle: paragraphStyle,
//			NSAttributedString.Key.foregroundColor : UIColor.gray
//		]
//
//		let textRect = CGRect(x: 340, y: 420, width: pageRect.width - 40 ,height: 80)
//		quoteDescription.draw(in: textRect, withAttributes: attributes)
//	}
//
//	private func addQuoteCost(quoteCost: Int){
//
//		let quoteCost1 = "$\(quoteCost)"
//
//		let attributes = [
//			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
//			//NSAttributedString.Key.paragraphStyle: paragraphStyle,
//			NSAttributedString.Key.foregroundColor : UIColor.gray
//		]
//
//		let textRect = CGRect(x: 340, y: 550, width: pageRect.width - 40 ,height: 80)
//		quoteCost1.draw(in: textRect, withAttributes: attributes)
//	}
}



// Here is where we add data about pdf
extension PdfCreatorIR {
	func pdfData( title : String, body: String, job: Job) -> Data? {
//		let context = context.cgContext
		
		if let renderer = self.renderer {
			

			let data = renderer.pdfData  { ctx in
				
				let context = ctx.cgContext
				ctx.beginPage()
				
				addSubOneLogo(pageRect: pageRect, imageTop: 60, image: subOneMainLogo!)
				addBoatDiagram(pageRect: pageRect, imageTop: 60, image: boatDiagram!)
				
				addInspectionReportTitle() // "Inspection Report"
				addSubOneContact()
				
				addName(title: title)
				addQuoteNumber(quoteNumber: "\(job.invoice)")
				addMarina(body: body)
				addQuoteDate(quoteDate: job.startDate!)
				addDiveSupervisor()
				addDiver(diver: "Anthony Saviano")
				addVessel(vessel: "Ericsson 27'")
				addVesselType(vesselType: "Sail")
				lastHaulOut(haulOutDate: "JUN 2023")
				
				addHullTitle()     // HULL
				addRunnningGearTitle()  // RUNNING GEAR
				
				
//				addInvoiceStaticText2()
//				addQuoteDescription(quoteDescription: job.description)
//				addQuoteCost(quoteCost: Int(job.amount))
				
				
				// Needs to be drawn below
				drawTopBeautyLine(context, pageRect: pageRect, height: 90) // pageRect.height - 300
				
				drawBeautyBoxTitles(context, pageRect: pageRect, height: 300)
				
			}
			return data
		}
		return nil
	}
}

// Is this where pdf is created?

extension PdfCreatorIR {
	
	func pdfDoc( title : String, body: String, job: Job ) -> PDFDocument? {
		
		if let data = self.pdfData(title: title, body: body, job: job){
			
			return PDFDocument(data: data)   // return a pdf document with data
		}
		
		return nil
	}
}

extension PdfCreatorIR {
	
//	func addWaterMarkAtBottom(){
//
//		if let logo = UIImage(named: "techchee_logo") {
//
//			let attributes = [
//				NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
//				NSAttributedString.Key.foregroundColor : UIColor.lightGray
//			]
//
//			let logoAt = CGRect(x: pageRect.size.width - (logo.size.width + 10), y: pageRect.height - (logo.size.height + 10),
//								width: logo.size.width, height: logo.size.height)
//
//
//			let textAt = CGRect (x: logoAt.origin.x - 102, y : logoAt.origin.y + 2, width:100, height: 30 )
//
//			let text  = "Created By "
//
//			text.draw(in : textAt, withAttributes : attributes)
//
//			logo.draw(in: logoAt)
//
//		}
//	}
}
