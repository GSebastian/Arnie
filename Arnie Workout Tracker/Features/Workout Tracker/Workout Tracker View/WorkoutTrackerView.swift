//
//  WorkoutTrackerView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 08/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct WorkoutTrackerView: View {
    
    @ObservedObject var viewModel: WorkoutTrackerViewModel
    
    @Binding var isPresented: Bool
    
    let workoutPlan: WorkoutPlan
    
    init(workoutPlan: WorkoutPlan,
         viewModel: WorkoutTrackerViewModel,
         isPresented: Binding<Bool>) {
        self.workoutPlan = workoutPlan
        self.viewModel = viewModel
        self._isPresented = isPresented
    }
    
    var body: some View {
        HStack {
            Group {
                switch viewModel.currentVM {
                case .time(let vm):
                    TimedSetTrackerView(viewModel: vm)
                        .padding()
                case .rep(let vm):
                    RepSetTrackerView(viewModel: vm)
                case .break(let vm):
                    BreakTrackerView(viewModel: vm)
                        .padding()
                case .finished:
                    WorkoutFinishedView(
                        viewModel: .init(),
                        isPresented: $isPresented)
                        .padding()
                case .none:
                    EmptyView()
                }
            }
            .backgroundFill(Color(.secondarySystemBackground))
            .mask(RoundedRectangle(cornerRadius: 8))
            .padding()
            .id(viewModel.currentVM)
            .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
            .animation(Animation.easeOut(duration: 0.35))
        }
    }
}

struct WorkoutTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTrackerView(workoutPlan: NewDataService().workouts.first!,
                           viewModel: WorkoutTrackerViewModel(
                            workoutPlan: NewDataService().workouts.first!),
                           isPresented: .constant(true))
    }
}
