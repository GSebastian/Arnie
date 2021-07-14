//
//  TimedSetTrackerViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 09/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Foundation

// TODO: Think about backgrounding

class TimedSetTrackerViewModel: SetViewModel<Int>, ObservableObject {
    @Published var timeLabel: String! = ""
    @Published var timerRunning: Bool = false
    let exerciseName: String

    private let setFinished: (SetResultType) -> Void
    private var timeCounter: Int {
        didSet {
            timeLabel = timeLabel(forSeconds: timeCounter)
        }
    }
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var cancellable: AnyCancellable?
    
    init(setPlan: SetPlan<Int>,
         setFinished: @escaping (SetResultType) -> Void) {
        self.timeCounter = setPlan.plannedResult ?? 0
        self.exerciseName = setPlan.exercise.name
        self.setFinished = setFinished
        super.init(setPlan: setPlan)
        self.timeLabel = timeLabel(forSeconds: setPlan.plannedResult ?? 0)
    }
    
    func start() {
        timerRunning = true
    }
    
    func pause() {
        timerRunning = false
    }
    
    func stop() {
        timerRunning = false
        setFinished(.time(setResult: NewSetResult(result: timeCounter, setPlan: setPlan)))
    }
    
    // MARK: - Lifecycle
    
    func onAppear() {
        cancellable = timer.sink { [weak self] _ in
            guard let self = self else { return }
            guard self.timerRunning else { return }
            if self.setPlan.plannedResult == nil {
                self.timeCounter += 1
            } else {
                self.timeCounter -= 1
            }
        }
    }
    
    func onDisappear() {
        cancellable?.cancel()
    }
    
    // MARK: - Utils
    
    private func timeLabel(forSeconds seconds: Int) -> String {
        let localizedWithPlaceholders =
            NSLocalizedString("setPlan.timeSetPlan.primaryLabel", comment: "")
        return String(format: localizedWithPlaceholders, seconds)
    }
}
