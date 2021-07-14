//
//  TextRecognitionService.swift
//  Arnie MOCK
//
//  Created by Sebastian Ghetu on 05/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation
import UIKit

class TextRecognitionService: TextRecognitionServiceProtocol {
    
    func textFromImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion("Mock")
        }
    }
    
    // MARK: - Utils
}
