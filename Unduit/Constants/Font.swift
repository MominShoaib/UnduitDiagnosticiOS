//
//  Font.swift

//
//  Created by Vivek Patel on 09/01/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    
    case small = 15.0
    case medium = 17.0
    case large = 19.0
    case tabbarfont = 12.0
    case navBarLargerTitle = 24.0

}
extension UIFont {
    
    enum Campton:String {
        
        case light = "Campton-Light"
        case medium = "Campton-Medium"
        case bold = "Campton-Bold"

        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
  
}

