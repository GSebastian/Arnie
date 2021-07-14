//
//  AuthenticatedDataProvider.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Firebase
import FirebaseUI
import Foundation

protocol FirebaseAuthenticatedDataProvider { }

extension FirebaseAuthenticatedDataProvider {

    var currentUser: User? {
        Auth.auth().currentUser
    }

    func ifAuthenticated<Success>(_ block: (String) -> AnyPublisher<Success, Error>)
        -> AnyPublisher<Success, Error> {

            guard let currentUserID = currentUser?.uid else {
                return Fail(error: FirebaseDataProviderError.unauthenticated).eraseToAnyPublisher()
            }
            return block(currentUserID)
    }
}
