//
//  TextRecognitionService.swift
//  Arnie PROD
//
//  Created by Sebastian Ghetu on 05/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TextRecognitionService: TextRecognitionServiceProtocol {
    
    lazy var vision = Vision.vision()
    
    func textFromImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        let visionImage = VisionImage(image: image)
        
        let options = VisionCloudTextRecognizerOptions()
        options.languageHints = ["en"]
        
        vision
            .cloudTextRecognizer(options: options)
            .process(visionImage) { (visionText, error) in
            guard error == nil, let visionText = visionText else {
                completion(nil)
                return
            }
            completion(visionText.text)
        }
    }
    
    // MARK: - Utils
}
