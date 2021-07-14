//
//  SetPlanGrouping.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 08/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import FirebaseFirestoreSwift
import Foundation

struct SetPlanGrouping: Codable, Hashable {
    var id = UUID()
    var name: String?
    var sets: [SetPlanType]
}
