//
//  TextRecognitionService.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 02/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation
import UIKit

protocol TextRecognitionServiceProtocol {
    
    func textFromImage(_ image: UIImage, completion: @escaping (String?) -> Void)
}

