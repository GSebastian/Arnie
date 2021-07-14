//
//  PastWorkoutsView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 11/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct PastWorkoutsView: View {

    @ObservedObject var viewModel: PastWorkoutsViewModel

    @State private var showingAlert = false
    @State private var positionsToBeDeleted: IndexSet?

    var body: some View {
        Group {
            NavigationView {
                List {
                    ForEach(viewModel.pastWorkouts, id: \.id) { pastWorkout in
                        NavigationLink(destination: PastWorkoutView(workoutResult: pastWorkout)) {
                            PrimarySecondaryTertiaryTextCellView(data: pastWorkout)
                        }
                    }
                    .onDelete(perform: startDeletingItems(at:))
                }
                .navigationBarTitle("pastWorkouts.home.navBar", displayMode: .large)
            }
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text("pastWorkouts.home.removeWorkoutAlert.title"),
                message: Text("pastWorkouts.home.removeWorkoutAlert.message"),
                primaryButton: .destructive(Text("pastWorkouts.home.removeWorkoutAlert.confirmButton"), action: confirmDeletingItems),
                secondaryButton: .default(Text("pastWorkouts.home.removeWorkoutAlert.cancelButton"), action: cancelDeletingItems))
        })
        .onAppear(perform: viewModel.viewDidAppear)
    }

    private func startDeletingItems(at positions: IndexSet?) {
        showingAlert = true
        positionsToBeDeleted = positions
    }

    private func cancelDeletingItems() {
        positionsToBeDeleted = nil
    }

    private func confirmDeletingItems() {
        guard let positionsToBeDeleted = positionsToBeDeleted else { return }
        viewModel.deleteItems(at: positionsToBeDeleted)
        self.positionsToBeDeleted = nil
    }
}

struct PastWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        PastWorkoutsView(viewModel: PastWorkoutsViewModel(pastWorkouts: [NewDataService().samplePastWorkout]))
    }
}
