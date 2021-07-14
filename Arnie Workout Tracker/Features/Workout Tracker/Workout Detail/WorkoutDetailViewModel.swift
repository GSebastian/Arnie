//
//  WorkoutDetailViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 15/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation
import UIKit

class WorkoutDetailViewModel: ObservableObject {

    @Published var workoutStarted: Bool = false

    func startWorkout() {
        workoutStarted = true
        UIApplication.shared.isIdleTimerDisabled = true
    }
}
