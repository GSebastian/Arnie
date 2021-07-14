//
//  TimedSetTrackerView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 08/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct TimedSetTrackerView: View {
    @ObservedObject var viewModel: TimedSetTrackerViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if !viewModel.timerRunning {
                    Spacer()
                }
                
                TimedSetTrackerView_InitialView(viewModel: viewModel)
                
                if viewModel.timerRunning {
                    Spacer()
                    Text(viewModel.timeLabel)
                        .font(.title)
                        .foregroundColor(Color(.secondaryLabel))
                }
                
                Spacer()
                
                if viewModel.timerRunning {
                    TimedSetTrackerView_Controls(viewModel: viewModel)
                }
            }
            Spacer()
        }
        .animation(.easeInOut(duration: 0.2))
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
    
    func timeRemainingText(timeRemaining: Int) -> String {
        let localizedWithPlaceholders =
            NSLocalizedString("setPlan.timeSetPlan.primaryLabel", comment: "")
        return String(format: localizedWithPlaceholders, timeRemaining)
    }
}

fileprivate struct TimedSetTrackerView_InitialView: View {
    @ObservedObject var viewModel: TimedSetTrackerViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text(viewModel.exerciseName)
                    .font(.largeTitle)
                    .foregroundColor(Color(.label))
                
                if !viewModel.timerRunning {
                    Text(viewModel.timeLabel)
                        .font(.headline)
                        .foregroundColor(Color(.secondaryLabel))
                }
                
                if !viewModel.timerRunning {
                    Button(action: {
                        self.viewModel.start()
                    }) {
                        Text("Start")
                            .font(.title)
                    }
                }
            }

            if viewModel.timerRunning { Spacer() }
        }
    }
}

fileprivate struct TimedSetTrackerView_Controls: View {
    
    @ObservedObject var viewModel: TimedSetTrackerViewModel
    
    var body: some View {
        HStack {
            Spacer()

            VStack(alignment: .trailing) {
                Button(action: {
                    self.viewModel.pause()
                }) {
                    Text("timedSetTracker.pause")
                        .font(.headline)
                        .padding([.leading, .vertical], 8)
                }

                Button(action: {
                    self.viewModel.stop()
                }) {
                    Text("timedSetTracker.nextSet")
                        .font(.title)
                        .padding([.leading, .top], 8)
                }
            }
        }
    }
}

struct TimedSetTrackerView_Previews: PreviewProvider {
    static var viewModel: TimedSetTrackerViewModel =
        TimedSetTrackerViewModel(
            setPlan: SetPlan(exercise: .plank, plannedResult: 40)) { _ in }
    
    static var previews: some View {
        Group {
            TimedSetTrackerView(viewModel: viewModel)
            
            TimedSetTrackerView_InitialView(viewModel: viewModel)
                .previewLayout(.fixed(width: 400, height: 250))
            
            TimedSetTrackerView_Controls(viewModel: viewModel)
                .previewLayout(.fixed(width: 400, height: 250))
        }
    }
}
