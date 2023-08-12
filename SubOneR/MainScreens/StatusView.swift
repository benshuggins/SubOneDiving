//
//  StatusView.swift
//  SubOneR
//
//  Created by Ben Huggins on 8/10/23.
//

// StatusView is currently not adding anyting into Core data

import SwiftUI

struct StatusView: View {
	
	@Binding var rating: Int

	var label = ""

	var maximumRating = 5

	var offImage: Image?
	var onImage = Image(systemName: "star.fill")

	var offColor = Color.gray
	var onColor = Color.yellow
	
	var body: some View {
		HStack {
			if label.isEmpty == false {
				Text(label)
			}

			ForEach(1..<maximumRating + 1, id: \.self) { number in
				image(for: number)
					.foregroundColor(number > rating ? offColor : onColor)
					.onTapGesture {
						rating = number
					}
			}
		}
	}
	
	func image(for number: Int) -> Image {
		if number > rating {
			return offImage ?? onImage
		} else {
			return onImage
		}
	}
}

struct StatusView_Previews: PreviewProvider {
	static var previews: some View {
		StatusView(rating: .constant(4))
	}
}
