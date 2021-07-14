//
//  WorkoutPlan.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 13/04/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

struct WorkoutPlan: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var plannedSetGroups: [SetPlanGrouping]
}

extension WorkoutPlan: PrimarySecondaryTertiaryTextCellDisplayable {
    var primaryText: String? { name }
    var secondaryText: String? { description }
    var tertiaryText: String? { nil }
}
