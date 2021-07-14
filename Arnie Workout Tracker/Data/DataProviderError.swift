//
//  DataProviderError.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

enum FirebaseDataProviderError: LocalizedError {
    case unauthenticated
    case write(originalError: Error?)
    case read(originalError: Error?)

    var errorDescription: String? {
        switch self {
        case .unauthenticated:
            return "Failed to authenticate the user"
        case .write(let originalError):
            return "Failed to write to database with error: \(originalError?.localizedDescription ?? "unknown")"
        case .read(let originalError):
            return "Failed to read from database with error: \(originalError?.localizedDescription ?? "unknown")"
        }
    }
}
