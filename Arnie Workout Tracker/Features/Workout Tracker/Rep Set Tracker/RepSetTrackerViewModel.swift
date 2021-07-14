//
//  RepSetTrackerViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 17/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Foundation

class RepSetTrackerViewModel: SetViewModel<Int>, ObservableObject {

    let exerciseName: String
    let plannedResultString: String
    var intPickerViewModel: IntPickerViewModel

    private var currentSelection: Int? = nil
    private let setFinished: (SetResultType) -> Void
    private var intPickerCancellable: Cancellable!
    
    init(setPlan: SetPlan<Int>,
         setPlanType: SetPlanType,
         setFinished: @escaping (SetResultType) -> Void) {
        self.intPickerViewModel = IntPickerViewModel(currentValue: nil)
        self.exerciseName = setPlan.exercise.name
        self.plannedResultString = setPlanType.plannedResultString
        self.setFinished = setFinished
        super.init(setPlan: setPlan)
        intPickerCancellable = intPickerViewModel.$currentValue.sink { [weak self] currentValue in
            guard let currentValue = currentValue else { return }
            self?.setFinished(.reps(setResult: NewSetResult(result: currentValue, setPlan: setPlan)))
        }
    }
    
    func valueSelected(_ value: Int?) {
        currentSelection = value
    }
    
    // MARK: - Lifecycle
}
