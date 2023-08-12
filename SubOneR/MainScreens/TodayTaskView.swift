//
//  TodayTaskView.swift
//  SubOneR
//
//  Created by Ben Huggins on 7/7/23.
//

import SwiftUI

struct TodayTaskView: View {
	@Environment(\.managedObjectContext) var moc
	
	
	@FetchRequest(sortDescriptors: []) var jobs: FetchedResults<Job>
	
	
	var body: some View {
		List {
			ForEach(jobs) { job in
				VStack(alignment: .leading) {
					Text(job.unwrappedNameJob)
					Text("Invoice #: \(job.invoice)" ?? "") // why arent default values showing up?
					}
			}
		}
		
//        Text("This shows all Potential Customers whether Sub One has done work for them or not. If you call Anthony and you sound like you aren't ready for a job you get entered here, if you sound serious you go in quote View, all we need is a name and a number at minimum. We can call potentials out of this. Every person that Sub One ever encounters goes in here        You can push a customer from here into Unpaid Jobs tab to start work for someone that was entered into this tab")
	}
}

struct TodayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTaskView()
    }
}
