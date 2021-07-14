//
//  DataProvider.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 18/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Firebase
import FirebaseUI
import Foundation

protocol DataProvider { }

class FirebaseDataProvider {
    static let sharedInstance = FirebaseDataProvider()

    let workoutDataProvider = FirebaseWorkoutDataProvider()
    let exerciseDataProvider = FirebaseExerciseDataProvider()
}
