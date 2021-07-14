//
//  SetPlanGroupingResult.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 14/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

struct SetPlanGroupingResult: Codable, Hashable {
    var id = UUID()
    var breakLength: Int
    var name: String?
    var setResults: [SetResultType]
}
