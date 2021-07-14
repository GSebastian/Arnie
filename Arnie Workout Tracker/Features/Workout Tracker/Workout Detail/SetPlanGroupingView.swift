//
//  SetPlanGroupingView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 08/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct SetPlanGroupingView: View {
    let setPlanGrouping: SetPlanGrouping
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                if setPlanGrouping.name != nil {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(setPlanGrouping.name!)
                            .font(.headline)
                        Divider()
                            .foregroundColor(Color(.separator))
                    }
                }
                ForEach(setPlanGrouping.sets, id: \.id) { set in
                    VStack {
                        HStack(alignment: .top) {
                            Text(set.exercise.name)
                                .font(.body)
                                .foregroundColor(Color(.label))
                            Spacer()
                            Text(set.plannedResultString)
                                .font(.body)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct WorkoutGroupingView_Previews: PreviewProvider {
    static var previews: some View {
        SetPlanGroupingView(setPlanGrouping: NewDataService().workouts[0].plannedSetGroups[0])
    }
}
