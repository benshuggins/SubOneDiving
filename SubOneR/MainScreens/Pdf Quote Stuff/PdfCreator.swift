//
//  PdfCreator.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/23/23.
//
// THIS I SA QUOTE



import Foundation
import PDFKit

// Default title and Body creator
class PdfCreator : NSObject {
	private var pageRect : CGRect
	private var renderer : UIGraphicsPDFRenderer?

	let imageLogo = UIImage(named: "SubOneMain")
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
extension PdfCreator {
	
	// LEFT SIDE
	private func addSubOneLogo(pageRect: CGRect, imageTop: CGFloat, image: UIImage) -> CGFloat {
		// 1
		let maxHeight = pageRect.height * 0.10
		let maxWidth = pageRect.width * 0.25
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
	
	private func addInvoiceStaticText (){
		let title = "Quote"
		let textRect = CGRect(x: 40, y: 150,
						 width: pageRect.width - 40 ,height: 40)
		title.draw(in: textRect,
			  withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)])
	}
	

	private func addSubOneContact () {
		
		var str2 = """
  415-840-4666
  anthony@subonediving.com
  
  SUB ONE DIVING INC
  1784 SMITH AVE
  SAN JOSE, CA 95112
  """
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .justified
		
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.foregroundColor : UIColor.gray
		]
		
		let bodyRect = CGRect(x: 40, y: 300,
							  width: pageRect.width - 40 ,height: pageRect.height - 80)
		str2.draw(in: bodyRect, withAttributes: attributes)
	}
	
	
	// RIGHT SIDE
	private func addName (title  : String ){
		let textRect = CGRect(x: 340, y: 300,
						 width: pageRect.width - 40 ,height: 40)
		title.draw(in: textRect,
			  withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
	}
		
	// Marina
	private func addMarina (body : String) {
		
		let marina = "Marina: \(body)"
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .justified
		
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.foregroundColor : UIColor.gray
		]
		
		let bodyRect = CGRect(x: 340, y: 320,
							  width: pageRect.width - 40 ,height: pageRect.height - 80)
		marina.draw(in: bodyRect, withAttributes: attributes)
	}
	
	private func addQuoteNumber(quoteNumber : String) {
		
		let quoteNumber1 = "Invoice #: \(quoteNumber)"
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .justified
		
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.foregroundColor : UIColor.gray
		]
		
		let bodyRect = CGRect(x: 340, y: 340,
							  width: pageRect.width - 40 ,height: pageRect.height - 80)
		quoteNumber1.draw(in: bodyRect, withAttributes: attributes)
	}
	
	private func addQuoteDate(quoteDate: Date ){
		
		var quoteDate1 = ""
		let formatter2 = DateFormatter()
		formatter2.dateStyle = .medium
		quoteDate1 = formatter2.string(from: quoteDate)
		
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
			//NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.foregroundColor : UIColor.gray
		]
		
		let textRect = CGRect(x: 340, y: 360,
						 width: pageRect.width - 40 ,height: 40)
		quoteDate1.draw(in: textRect,
			  withAttributes: attributes)
	}
	private func addInvoiceStaticText2 (){
		let title = "Description"
		let textRect = CGRect(x: 340, y: 400,
						 width: pageRect.width - 40 ,height: 40)
		title.draw(in: textRect,
			  withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
	}
	
	private func addQuoteDescription(quoteDescription: String){
				
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
			//NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.foregroundColor : UIColor.gray
		]
		
		let textRect = CGRect(x: 340, y: 420,
						 width: pageRect.width - 40 ,height: 80)
		quoteDescription.draw(in: textRect,
			  withAttributes: attributes)
	}
	
	private func addQuoteCost(quoteCost: Int){
		
		let quoteCost1 = "$\(quoteCost)"
				
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
			//NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.foregroundColor : UIColor.gray
		]
		
		let textRect = CGRect(x: 340, y: 550,
						 width: pageRect.width - 40 ,height: 80)
		quoteCost1.draw(in: textRect,
			  withAttributes: attributes)
	}
}

extension PdfCreator {
	func pdfData( title : String, body: String, job: Job) -> Data? {
		if let renderer = self.renderer {

			let data = renderer.pdfData  { ctx in
				ctx.beginPage()
				
				addSubOneLogo(pageRect: pageRect, imageTop: 60, image: imageLogo!)
				addInvoiceStaticText() // "Invoice"
				addSubOneContact ()
				
				addName(title: title)
				addMarina(body: body)
				addQuoteDate(quoteDate: job.startDate!)
				addQuoteNumber(quoteNumber: "\(job.invoice)")
				addInvoiceStaticText2()
				addQuoteDescription(quoteDescription: job.description)
				addQuoteCost(quoteCost: Int(job.amount))
			}
			return data
		}
		return nil
	}
}

extension PdfCreator {
	
	func pdfDoc( title : String, body: String, job: Job ) -> PDFDocument? {
		
		if let data = self.pdfData(title: title, body: body, job: job){
			
			return PDFDocument(data: data)
		}
		
		return nil
	}
}

extension PdfCreator {
	
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
