//
//  LoginView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/7/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
	
	@Environment(\.colorScheme) var colorScheme
	
	@AppStorage("email") var email: String = ""
	@AppStorage("firstName") var firstName: String = ""
	@AppStorage("lastName") var lastName: String = ""
	@AppStorage("userId") var userId: String = ""
	
	
    var body: some View {
		NavigationView {
			VStack {
				
				if userId.isEmpty {
					SignInWithAppleButton(.continue) { request in
						
						request.requestedScopes = [.email, .fullName]
						
					} onCompletion: { result in
						
						switch result {
							case .success(let auth):
								let _ = print("Logged In") // 3
								
								
								
								switch auth.credential {
									case let credential as ASAuthorizationAppleIDCredential:
										
										let userId = credential.user
										
										let email = credential.email
										let firstName = credential.fullName?.givenName
										let lastName = credential.fullName?.familyName
									
									default:
										break
										
								}
								

							case .failure(let error):
								print(error)
						}
					}
					.signInWithAppleButtonStyle(
						colorScheme == .dark ? .white : .black
						)
						.frame(height: 50)
						.padding()
						.cornerRadius(8)
				}
				else {
					//Text("Welcome Back")
					let _ = print("Logged In") // 3
				}
				
				
				
				
			}
			.navigationTitle("Sign In")
		}
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
