//
//  PastWorkoutsViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 12/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Firebase
import Foundation

class PastWorkoutsViewModel: ObservableObject {

    @Published var pastWorkouts: [WorkoutResult]

    init(pastWorkouts: [WorkoutResult] = []) {
        self.pastWorkouts = pastWorkouts
    }

    func viewDidAppear() {
        reloadItems()
    }

    func deleteItems(at positions: IndexSet) {
        let workoutIDs = positions.compactMap({ pastWorkouts[$0].id })
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        for id in workoutIDs {
            Firestore
                .firestore()
                .collection("users")
                .document(currentUserId)
                .collection("workouts")
                .document(id)
                .delete()
        }
        reloadItems()
    }

    private func reloadItems() {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            pastWorkouts = []
            return
        }
        Firestore
            .firestore()
            .collection("users")
            .document(currentUserId)
            .collection("workouts")
            .order(by: "dateFinished", descending: true)
            .getDocuments(completion: { [weak self] (snapshot, error) in
                self?.pastWorkouts =
                    snapshot?
                        .documents
                        .compactMap({ try? $0.data(as: WorkoutResult.self) }) ?? []
            })
    }
}
