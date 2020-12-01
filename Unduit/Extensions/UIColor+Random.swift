//
//  UIColor+Random.swift
//
//  Created by Vivek Patel on 28/01/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
