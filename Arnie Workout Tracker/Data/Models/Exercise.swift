//
//  Exercise.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 03/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import FirebaseFirestoreSwift
import Foundation

struct Exercise: Equatable, Hashable, Codable {
    var name: String
    var description: String?
}

//extension DocumentID: Hashable where Value: Hashable {
//
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(wrappedValue)
//    }
//}

extension Exercise: PrimarySecondaryTertiaryTextCellDisplayable {

    var primaryText: String? { name }

    var secondaryText: String? { description }

    var tertiaryText: String? { nil }
}
