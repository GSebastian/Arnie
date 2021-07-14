//
//  Date+PrettyFormatting.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 12/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

extension Date {

    func prettyFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "MMM d, yyyy"

        return dateFormatter.string(from: self)
    }
}
