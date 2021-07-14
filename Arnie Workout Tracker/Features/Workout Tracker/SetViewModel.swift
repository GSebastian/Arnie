//
//  SetViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 17/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

class SetViewModel<ResultType: Codable & Hashable>: Equatable, Identifiable, Hashable {
    
    let setPlan: SetPlan<ResultType>

    init(setPlan: SetPlan<ResultType>) {
        self.setPlan = setPlan
    }
    
    // MARK: - Equatable
    
    static func == (lhs: SetViewModel, rhs: SetViewModel) -> Bool {
        lhs.setPlan == rhs.setPlan
    }
    
    // MARK: - Identifiable
    
    var id: String {
        setPlan.id
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(setPlan)
    }
}

enum SetViewModelEnum: Hashable {
    case time(vm: TimedSetTrackerViewModel)
    case rep(vm: RepSetTrackerViewModel)
    case `break`(vm: BreakTrackerViewModel)
    case finished
}
