//
//  WorkoutResult.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 03/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import FirebaseFirestoreSwift
import Foundation

struct WorkoutResult: Identifiable, Codable {
    @DocumentID var id = UUID().uuidString

    var name: String
    var dateFinished: Date = Date()
    var description: String?
    var setGroupResults: [SetPlanGroupingResult] = []
}

extension WorkoutResult: PrimarySecondaryTertiaryTextCellDisplayable {
    var primaryText: String? { name }
    var secondaryText: String? { dateFinished.prettyFormatted() }
    var tertiaryText: String? { description }
}
