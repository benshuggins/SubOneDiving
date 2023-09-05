//
//  MainView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/7/23.
//

// Send data to another model with a a checkbox so send a checkmark on undpaid to a separate screen

// add search bars 

import SwiftUI


struct MainView: View {
    var body: some View {
		TabView {
			ContentView()
				.tabItem {
					Label("Customers", systemImage: "list.dash")
				}
			TodayTaskView()
				.tabItem {
					Label("Needs Work", systemImage: "sun.max.trianglebadge.exclamationmark")
				}
//			
//			QuoteView()
//				.tabItem {
//					Label("Quotes", systemImage: "text.quote")
//				}
			
			HistoryView()
				.tabItem {
					Label("Complete", systemImage: "fossil.shell")
				}
			AllCustomers()
				.tabItem {
					Label("Customers", systemImage: "person.fill.badge.plus")
				}
		}
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
