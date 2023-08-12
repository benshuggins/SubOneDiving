//
//  SubOneRApp.swift
//  SubOneR
//
//  Created by Ben Huggins on 6/28/23.
//

import SwiftUI
import CoreData

@main
struct SubOneRApp: App {
	
	@StateObject private var dataController = DataController()
	
	var body: some Scene {
		
		WindowGroup {
		//	SignInView()
			
			MainView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
				.onAppear {
					UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
					print(UIDevice.current.systemVersion)
					print(UIDevice.current.modelName)
					print(Bundle.main.displayName)
					print(Bundle.main.appVersion)
					print(Bundle.main.appBuild)
				}
		}
		
//		DocumentGroup(newDocument: TextFile()) { file in
//			QuoteView(document: .constant(TextFile()))
//			
//		}
	}
	}

