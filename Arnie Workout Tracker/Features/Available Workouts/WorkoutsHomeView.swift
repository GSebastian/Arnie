//
//  ContentView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 13/04/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct WorkoutsHomeView: View {
    @EnvironmentObject var data: NewDataService

    @State private var exercisesDisplayed: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.workouts) { workout in
                    NavigationLink(destination: WorkoutDetailView(workoutPlan: workout, viewModel: WorkoutDetailViewModel())) {
                        PrimarySecondaryTertiaryTextCellView(data: workout)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle(
                NSLocalizedString(
                    "workoutPlans.home.navBar",
                    comment: ""))
            .navigationBarItems(
                trailing: Button(
                    action: { self.exercisesDisplayed.toggle() },
                    label: { Text("Exercises") }))
        }
        .sheet(
            isPresented: $exercisesDisplayed,
            content: ({
                ExercisesHomeView(
                    exercisesViewModel: ExercisesViewModel(),
                    addExerciseViewModel: AddExerciseViewModel())
            }))
    }
}

struct WorkoutsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsHomeView().environmentObject(NewDataService())
    }
}
