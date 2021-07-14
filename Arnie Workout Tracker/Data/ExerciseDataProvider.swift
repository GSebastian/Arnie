//
//  ExerciseDataProvider.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Firebase
import Foundation

protocol ExerciseDataProvider { }

class FirebaseExerciseDataProvider: ExerciseDataProvider, FirebaseAuthenticatedDataProvider {

    // MARK: - Get Exercises

    func getExercises() -> AnyPublisher<[Exercise], Error> {
        getPublicExercises()
            .combineLatest(getUserExercises())
            .map({ $0 + $1 })
            .map({ $0.sorted(by: { $0.name < $1.name })})
            .eraseToAnyPublisher()
    }

    private func getPublicExercises() -> AnyPublisher<[Exercise], Error> {
        getExercises(from: Firestore.firestore().collection("public-exercises"))
    }

    private func getUserExercises() -> AnyPublisher<[Exercise], Error> {
        ifAuthenticated { currentUserID in
            getExercises(from:
                Firestore
                    .firestore()
                    .collection("users")
                    .document(currentUserID)
                    .collection("exercises"))
        }
    }

    private func getExercises(from collection: CollectionReference) -> AnyPublisher<[Exercise], Error> {
        let subject = PassthroughSubject<[Exercise], Error>()
        collection
            .addSnapshotListener(includeMetadataChanges: false, listener: { (snapshot, error) in
                guard error == nil else {
                    subject.send(completion: .failure(FirebaseDataProviderError.read(originalError: error)))
                    return
                }
                guard let documents = snapshot?.documents else {
                    subject.send(completion: .failure(FirebaseDataProviderError.read(originalError: nil)))
                    return
                }
                let mappedExercises = documents.compactMap { snapshot -> Exercise? in
                    try? snapshot.data(as: Exercise.self)
                }
                subject.send(mappedExercises)
            })
        return subject.eraseToAnyPublisher()
    }

    // MARK: - Create Exercise

    func saveExercise(_ exercise: Exercise) -> AnyPublisher<Void, Error> {
        func saveExercise(userID: String, exercise: Exercise) -> AnyPublisher<Void, Error> {
            Future<Void, Error> { promise in
                do {
                    try Firestore
                        .firestore()
                        .collection("users")
                        .document(userID)
                        .collection("exercises")
                        .document(UUID().uuidString)
                        .setData(from: exercise) { (error) in
                            if let error = error {
                                promise(.failure(error))
                            } else {
                                promise(.success(()))
                            }
                    }
                } catch {
                    promise(.failure(error))
                }
            }.eraseToAnyPublisher()
        }

        return ifAuthenticated { currentUserID in
            saveExercise(userID: currentUserID, exercise: exercise)
        }
    }
}
