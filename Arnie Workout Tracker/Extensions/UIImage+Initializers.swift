//
//  UIImage+Initializers.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 02/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage.init(cgImage: image!.cgImage!)
    }
}
