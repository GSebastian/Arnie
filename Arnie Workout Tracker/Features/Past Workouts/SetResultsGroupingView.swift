//
//  PastWorkoutView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 08/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct SetResultsGroupingView: View {
    let setResultsGrouping: SetPlanGroupingResult

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                if setResultsGrouping.name != nil {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(setResultsGrouping.name!)
                            .font(.headline)
                        Divider()
                            .foregroundColor(Color(.separator))
                    }
                }
                ForEach(setResultsGrouping.setResults, id: \.id) { set in
                    VStack {
                        HStack(alignment: .top) {
                            Text(set.exercise.name)
                                .font(.body)
                                .foregroundColor(Color(.label))
                            Spacer()
                            Text(set.title)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.systemTeal)
                        }
                    }
                }
                Divider()
                    .foregroundColor(Color(.separator))
                HStack(alignment: .top) {
                    Text("pastWorkouts.workoutResult.setGroupingResult.breakLabel")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.label))
                    Spacer()
                    Text(breakValueText())
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.systemTeal)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }

    private func breakValueText() -> String {
        let stringWithPlaceholders =
            NSLocalizedString(
                "pastWorkouts.workoutResult.setGroupingResult.breakValue",
                comment: "")
        return String(format: stringWithPlaceholders,
                      setResultsGrouping.breakLength)
    }
}

struct SetResultsGroupingView_Previews: PreviewProvider {
    static var previews: some View {
        SetResultsGroupingView(setResultsGrouping: NewDataService().samplePastWorkout.setGroupResults[0])
    }
}
