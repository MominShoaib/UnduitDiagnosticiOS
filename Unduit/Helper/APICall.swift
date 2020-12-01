//
//  APICall.swift

//
//  Created by Vivek Patel on 08/01/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import Alamofire


class APICall: NSObject {
   
    private static let AlamofireSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    class func postRequest(url:String,params:Parameters? ,completionHandler: @escaping CompletionBlock) -> Void{
          let qrTest = "e8c0e2704a88757268104eceaecace11ad4865289da3af5b271e397067e2b8ca-eac1b626"
        let defaults = AppUserDefaults()
       let qrCode = defaults.qr
        let headers:[String:String] = ["token":"SxkQsDDXNDQGAKZDsabggpckN-1016","qr_code_key":qrCode]
        print("headers:",headers)
        AlamofireSessionManager.request(url,method: .post, parameters: params, encoding:JSONEncoding.default,headers: headers)
            .responseJSON {response  in
                completionHandler(response)
        }
    }
    class func getRequest(url:String, params:Parameters?,completionHandler: @escaping CompletionBlock) -> Void{
        let qrTest = "e8c0e2704a88757268104eceaecace11ad4865289da3af5b271e397067e2b8ca-eac1b626"
        let defaults = AppUserDefaults()
         let qrCode = defaults.qr
        let headers:[String:String] = ["token":"SxkQsDDXNDQGAKZDsabggpckN-1016","qr_code_key":qrCode]
        print(headers)
        AlamofireSessionManager.request(url,method: .get, parameters: params, headers: headers)
            .responseJSON {response  in
                completionHandler(response)
        }
    }
    
}
