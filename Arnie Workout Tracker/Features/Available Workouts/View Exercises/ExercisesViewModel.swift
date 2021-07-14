//
//  ExercisesViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Foundation

class ExercisesViewModel: ObservableObject {
    
    @Published var exercises: [Exercise] = []
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    func onAppear() {
        reloadList()
    }
    
    func onDisappear() {
        cancellableSet.forEach({ $0.cancel() })
    }
    
    func reloadList() {
        FirebaseDataProvider
            .sharedInstance
            .exerciseDataProvider
            .getExercises()
            .replaceError(with: [])
            .assign(to: \.exercises, on: self)
            .store(in: &cancellableSet)
    }
}
