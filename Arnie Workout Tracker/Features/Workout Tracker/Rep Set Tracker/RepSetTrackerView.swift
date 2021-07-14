//
//  RepSetTrackerView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 08/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import SwiftUI

struct RepSetTrackerView: View {

    @ObservedObject var viewModel: RepSetTrackerViewModel

    var body: some View {
        ZStack(alignment: .leading) {
            IntPickerView(viewModel: viewModel.intPickerViewModel)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.exerciseName)
                            .font(.largeTitle)
                            .foregroundColor(Color(.label))

                        Text(viewModel.plannedResultString)
                            .font(.headline)
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    Spacer()
                }
                .padding()
                .backgroundFill(.secondarySystemBackground)

                Spacer()
            }
        }
    }
}

struct RepSetTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        RepSetTrackerView(viewModel: RepSetTrackerViewModel(
            setPlan: SetPlan(
                exercise: .chinUp,
                plannedResult: 50),
            setPlanType: .reps(
                plan: SetPlan(
                    exercise: .chinUp,
                    plannedResult: 50)),
            setFinished: { _ in }))
    }
}
