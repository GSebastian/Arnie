//
//  WorkoutTrackerViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 17/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Firebase
import FirebaseUI
import Foundation
import SwiftUI

class WorkoutTrackerViewModel: ObservableObject {
    
    @Published var currentVM: SetViewModelEnum!

    private let workoutPlan: WorkoutPlan
    private var viewModels: [SetViewModelEnum]!

    private var setResultsForGrouping: [SetPlanGrouping : [SetResultType]] = [:]
    private var breakLengthsForGrouping: [SetPlanGrouping : Int] = [:]
    
    init(workoutPlan: WorkoutPlan) {
        self.workoutPlan = workoutPlan
        self.viewModels = workoutPlan.plannedSetGroups.flatMap({ grouping -> [SetViewModelEnum?] in
            var viewModels =
                grouping.sets.map({ setPlanType -> SetViewModelEnum in
                    switch setPlanType {
                    case .reps(let setPlan):
                        return .rep(
                            vm: RepSetTrackerViewModel(
                                setPlan: setPlan,
                                setPlanType: setPlanType,
                                setFinished: ({ [weak self] result in
                                    self?.setFinished(result: result, in: grouping)
                                })))
                    case .time(let setPlan):
                        return .time(
                            vm: TimedSetTrackerViewModel(
                                setPlan: setPlan,
                                setFinished: ({ [weak self] result in
                                    self?.setFinished(result: result, in: grouping)
                                })))
                    }
                })
            
            viewModels.append(.break(vm: BreakTrackerViewModel(
                setPlanGrouping: grouping,
                setFinished: ({ [weak self] timeElapsed in
                    self?.breakFinished(length: timeElapsed, for: grouping)
                })))
            )
            
            return viewModels
        }).compactMap({ $0 })
        self.viewModels.append(.finished)
        self.currentVM = viewModels[0]
    }

    // MARK: - Private
    
    private func setFinished(result: SetResultType, in grouping: SetPlanGrouping) {
        if var results = setResultsForGrouping[grouping] {
            results.append(result)
            setResultsForGrouping[grouping] = results
        } else {
            let newArray = [result]
            setResultsForGrouping[grouping] = newArray
        }
        checkFinishedOrAdvanceVM()
    }

    private func breakFinished(length: Int, for grouping: SetPlanGrouping) {
        breakLengthsForGrouping[grouping] = length
        checkFinishedOrAdvanceVM()
    }

    private func checkFinishedOrAdvanceVM() {
        guard let currentVM = currentVM,
            let currentVMIndex = viewModels.firstIndex(of: currentVM) else {
                return
        }
        guard currentVMIndex < viewModels.count - 1 else {
            workoutFinished()
            return
        }
        self.currentVM = viewModels[currentVMIndex + 1]
        if case .finished = self.currentVM {
            workoutFinished()
        }
    }

    private func workoutFinished() {
        UIApplication.shared.isIdleTimerDisabled = false
        var workoutResult = WorkoutResult(name: workoutPlan.name, description: workoutPlan.description)
        for group in workoutPlan.plannedSetGroups {
            guard let resultsForGroup = setResultsForGrouping[group] else {
                continue
            }
            workoutResult
                .setGroupResults
                .append(
                    SetPlanGroupingResult(
                        breakLength: breakLengthsForGrouping[group] ?? 0,
                        setResults: resultsForGroup))
        }
        _ = FirebaseDataProvider
            .sharedInstance
            .workoutDataProvider
            .addWorkoutResult(workoutResult)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            }) {
                print("Workout saved!")
        }
    }
}

