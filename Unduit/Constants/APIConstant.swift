//
//  APIConstant.swift

//
//  Created by Vivek Patel on 08/01/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
extension URL{
    static let baseUrl = "https://www.unduitwireless.com/"
    static let host = baseUrl + "api/v2/"
    
    enum Test {
          static let getDiagnosticDeviceTest = host + "get_diagnostic_device_test"
          static let deviceTest = host + "diagnostic_device_test"
          static let updateDeviceInfo = host +  "update_diagnostic_device_data"
    }
    
    enum Key {
        static let accept = "Accept"
        static let contentType = "Content-Type"
        static let authorization = "Authorization"
    }
    enum Header {
        static let JSON = "application/json"
        static let URLEncoded = "application/x-www-form-urlencoded"
    }
    enum UserAuth {
        static let login = host + "login/empAuthentication?"
    }
    enum Scan {
        static let scan = host + "barcode/tokenBarcodeTransactionNew"
        static let requestQRCode = host + "qr_email"
    }
    
}

