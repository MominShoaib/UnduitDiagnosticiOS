//
//  MenuInfo.swift
//  Unduit
//
//  Created by Vivek Patel on 19/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import Foundation
import UIKit
enum MenuData:Int,CaseIterable {
    
    case generalTest = 0
    case audioTest = 1
    case cameraTest = 2
    case displayTest = 3
    case buttonTest = 4
    case sensorsTest = 5
    case conditionTest = 6
    
    var title:String{
        switch self {
        case .generalTest:
            return "General Test"
        case .audioTest:
            return "Audio Test"
        case .cameraTest:
            return "Camera Test"
        case .displayTest:
            return "Display Test"
        case .buttonTest:
            return "Button Test"
        case .sensorsTest:
            return "Sensors Test"
        case .conditionTest:
            return "Condition Test"
        }
    }
    
    var rightImage:UIImage{
        switch self {
        case .generalTest:
            return #imageLiteral(resourceName: "checked")
        case .audioTest:
            return #imageLiteral(resourceName: "checked")
        case .cameraTest:
            return #imageLiteral(resourceName: "checked")
        case .displayTest:
            return #imageLiteral(resourceName: "checked")
        case .buttonTest:
            return #imageLiteral(resourceName: "checked")
        case .sensorsTest:
            return #imageLiteral(resourceName: "checked")
        case .conditionTest:
            return #imageLiteral(resourceName: "checked")
            
        }
    }
    
    var leftImage:UIImage{
        switch self {
        case .generalTest:
            return #imageLiteral(resourceName: "book")
        case .audioTest:
            return #imageLiteral(resourceName: "speaker")
        case .cameraTest:
            return #imageLiteral(resourceName: "camera")
        case .displayTest:
            return #imageLiteral(resourceName: "displayTest")
        case .buttonTest:
            return #imageLiteral(resourceName: "buttonTest")
        case .sensorsTest:
            return #imageLiteral(resourceName: "sensers")
        case .conditionTest:
            return #imageLiteral(resourceName: "condition")
            
        }
    }
}
