//
//  WorkoutDataProvider.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Firebase
import Foundation

protocol WorkoutDataProvider { }

class FirebaseWorkoutDataProvider: WorkoutDataProvider, FirebaseAuthenticatedDataProvider {

    func addWorkoutResult(_ workoutResult: WorkoutResult) -> AnyPublisher<Void, Error> {
        ifAuthenticated { currentUserID  in
            do {
                _ = try Firestore
                    .firestore()
                    .collection("users")
                    .document(currentUserID)
                    .collection("workouts")
                    .addDocument(from: workoutResult)
            } catch {
                return Fail(error: FirebaseDataProviderError.write(originalError: error)).eraseToAnyPublisher()
            }
            return CurrentValueSubject(()).eraseToAnyPublisher()
        }
    }
}
