//
//  PastWorkoutView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 14/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct PastWorkoutView: View {

    var workoutResult: WorkoutResult

    var body: some View {
        List {
            Text(self.workoutResult.dateFinished.prettyFormatted())
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.systemTeal)

            ForEach(workoutResult.setGroupResults, id: \.id) { setGroupResult in
                SetResultsGroupingView(setResultsGrouping: setGroupResult)
            }
        }
        .navigationBarTitle("\(workoutResult.name)", displayMode: .large)
    }
}

struct PastWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        PastWorkoutView(workoutResult: NewDataService().samplePastWorkout)
    }
}
