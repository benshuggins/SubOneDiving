//
//  SignInView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/7/23.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
	
	enum signInStatus {
		case unknown
		case authorized
		case failure(Error?)
	}
	
	@State private var status = signInStatus.unknown
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.colorScheme) var colorScheme

	var body: some View {
		NavigationView {
			Group {
				switch status {
				case .unknown:
					VStack(alignment: .leading) {
						Image("SubOneMain")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.scaledToFit()
							.padding(.top, 15)
					

						Spacer()
						VStack {
							
								Spacer()
							SignInWithAppleButton(onRequest: configureSignIn, onCompletion: completeSignIn)
								.signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
								.frame(height: 44)
							
							Button("Cancel", action: close)
								.frame(maxWidth: .infinity)
								.padding()
						}
					}
				case .authorized:
					Text("You're all set!")
				case .failure(let error):
					if let error = error {
						Text("Sorry, there was an error: \(error.localizedDescription)")
					} else {
						Text("Sorry, there was an error.")
					}
				}
			}
			.padding()
			.navigationTitle("SubOne Login")
		}
	}
	
	func close() {
		presentationMode.wrappedValue.dismiss()
	}
	
	func configureSignIn(_ request: ASAuthorizationAppleIDRequest) {
		request.requestedScopes = [.fullName]
	}
	
	// This evaluates the result from sign in with apple
	func completeSignIn(_ result: Result<ASAuthorization, Error>) {
		switch result {
		   case .success(let auth):
			   // success
				if let appleId = auth.credential as? ASAuthorizationAppleIDCredential {
					if let fullName = appleId.fullName {
						let formatter = PersonNameComponentsFormatter()
						var username = formatter.string(from: fullName).trimmingCharacters(in: .whitespacesAndNewlines)
						
						
						if username.isEmpty {
							username = "User-\(Int.random(in: 1001...9999))"
						}
						UserDefaults.standard.set(username, forKey: "username")
						NSUbiquitousKeyValueStore.default.set(username, forKey: "username")
							   status = .authorized
							   close()
							   return
					}
						
				}
				status = .failure(nil)
				
		   case .failure(let error):
			   // failure
				if let error = error as? ASAuthorizationError {
					if error.errorCode == ASAuthorizationError.canceled.rawValue {
						status = .unknown
						return
					}
				}
				status = .failure(error)
		   }
		
	}
}

//struct SignInView_Previews: PreviewProvider {
//	static var previews: some View {
//		SignInView()
//	}
//}
