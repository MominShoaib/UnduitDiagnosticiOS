//
//  String+Validation.swift
//
//  Created by Vivek Patel on 08/01/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isVacate:Bool {
       return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    var totalCount:Int{
        return self.trimmingCharacters(in: .whitespaces).count
    }
    var trimmed:String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    
}
