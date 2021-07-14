//
//  IntPickerViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 16/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import SwiftUI

class IntPickerViewModel: ObservableObject {
    
    @Published var currentValue: Int?
    
    var rememberedScrollOffset: CGPoint = .zero 
    
    init(currentValue: Int?) {
        self.currentValue = currentValue
    }
}
