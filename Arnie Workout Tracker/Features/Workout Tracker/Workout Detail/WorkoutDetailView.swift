//
//  WorkoutDetailView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 13/04/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI
struct WorkoutDetailView: View {

    let workoutPlan: WorkoutPlan

    @ObservedObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            List {
                Text(self.workoutPlan.description)
                    .font(.body)
                    .foregroundColor(.primary)
                
                ForEach(0..<self.workoutPlan.plannedSetGroups.count) { index in
                    SetPlanGroupingView(setPlanGrouping: self.workoutPlan.plannedSetGroups[index])
                }
            }
            
            Spacer()

            Button(action: {
                self.viewModel.startWorkout()
            }) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Start")
                        .padding()
                        .foregroundColor(Color(.link))
                        .font(Font.headline.bold())
                    Spacer()
                }
                .background(Color(.systemGray6))
                .cornerRadius(6)
                .padding()
            }
        }
        .navigationBarTitle("\(workoutPlan.name)", displayMode: .large)
        .sheet(isPresented: $viewModel.workoutStarted, content: workoutTrackerView)
    }
    
    func workoutTrackerView() -> some View {
        return WorkoutTrackerView(
            workoutPlan: workoutPlan,
            viewModel: WorkoutTrackerViewModel(workoutPlan: workoutPlan), isPresented: $viewModel.workoutStarted)
            .navigationBarTitle(Text(workoutPlan.name), displayMode: .inline)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workoutPlan: NewDataService().workouts[0], viewModel: WorkoutDetailViewModel())
    }
}
