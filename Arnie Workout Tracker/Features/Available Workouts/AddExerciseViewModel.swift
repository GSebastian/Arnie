//
//  AddExerciseViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class AddExerciseViewModel: ObservableObject {
    
    @Published var errorText: String?
    
    var workoutSaved: AnyPublisher<Void, Never>!
    
    private let validNamePicked = PassthroughSubject<String, Never>()
    
    init() {
        workoutSaved =
            validNamePicked
                .first()
                .flatMap({
                    FirebaseDataProvider
                        .sharedInstance
                        .exerciseDataProvider
                        .saveExercise(
                            Exercise(
                                name: $0,
                                description: nil))
                        // TODO: Error handling
                        .catch({ _ -> Just<Void> in Just(()) })
                })
                .map({
                    // HACK: Having to dismiss the keyboard before navigating away
                    // from the page, as described here:
                    // https://stackoverflow.com/questions/58952203/swiftui-ios-app-crashes-when-state-change-causes-keyboard-to-resign-as-first-res
                    UIApplication
                        .shared
                        .sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to:nil,
                            from:nil,
                            for:nil)
                })
                .eraseToAnyPublisher()
    }
    
    func saveExercise(named exerciseName: String?) {
        guard let exerciseName = exerciseName else {
            errorText = NSLocalizedString("exercises.add.errorTextEmpty", comment: "")
            return
        }
        validNamePicked.send(exerciseName)
    }
}
