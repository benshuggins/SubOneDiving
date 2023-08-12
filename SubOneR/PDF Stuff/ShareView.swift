//
//  ShareView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/23/23.
//


import Foundation
import UIKit
import SwiftUI


struct ShareView: UIViewControllerRepresentable {
	let activityItems: [Any]
	let applicationActivities: [UIActivity]? = nil

	func makeUIViewController(context: UIViewControllerRepresentableContext<ShareView>) ->
		UIActivityViewController {
		return UIActivityViewController(activityItems: activityItems,
			   applicationActivities: applicationActivities)
	}

	func updateUIViewController(_ uiViewController: UIActivityViewController,
			   context: UIViewControllerRepresentableContext<ShareView>) {
		// empty
	}
}
