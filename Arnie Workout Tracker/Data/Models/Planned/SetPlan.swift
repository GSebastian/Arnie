//
//  SetPlan.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 08/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

struct SetPlan<ResultType: Codable & Hashable>: Hashable, Codable {

    var exercise: Exercise

    var id: String = UUID().uuidString

    var plannedResult: ResultType?
}
