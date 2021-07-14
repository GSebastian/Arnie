//
//  BreakTrackerView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 25/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct BreakTrackerView: View {
    
    @ObservedObject var viewModel: BreakTrackerViewModel
    
    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading) {
                Text("breakTracker.title")
                    .font(.largeTitle)
                    .foregroundColor(Color(.label))
                Text(viewModel.timeLabel)
                    .font(.title)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Button(action: {
                        self.viewModel.addMore()
                    }) {
                        Text("breakTracker.add10s")
                            .font(.headline)
                            .padding([.leading, .vertical], 8)
                    }
                    
                    Button(action: {
                        self.viewModel.nextSet()
                    }) {
                        Text("breakTracker.nextSet")
                            .font(.title)
                            .padding([.leading, .top], 8)
                    }
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
}

struct BreakTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        BreakTrackerView(viewModel: BreakTrackerViewModel(
            setPlanGrouping: SetPlanGrouping(
                name: "Test name",
                sets: [
                    .reps(plan: SetPlan(exercise: .chinUp, plannedResult: 5))
                ]
            ),
            setFinished: {_ in }))
    }
}
