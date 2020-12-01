//
//  AppUtility.swift

//
//  Created by Vivek Patel on 08/01/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import Alamofire
import MobileCoreServices
import UIKit

class AppUtility: NSObject {
    
    class func parseResponse(_ dataResponse:DataResponse<Any>, params:StrAny? = nil) -> (ResponseStatus) {
       
        switch dataResponse.result {
        case .success:
            
            guard let response = dataResponse.result.value as? StrAny else {
                return (data:nil, error:"Something went wrong, please try again later", status:.failure)
            }
            guard let status =  response["status"] as? Bool else {
                return (data:nil, error:"Something went wrong, please try again later", status:.failure)
            }
            let message = response["message"] as? String
            if status {
                return (data:response["response"], error:message, status:.success)
            }else{
                return (data:nil, error:message, status:.failure)
            }
        case .failure(let error):
            return (data:nil, error:error.localizedDescription, status:.failure)
        }
    }
    /*
    class func parseResponse(_ dataResponse:DataResponse<Any>, params:StrAny? = nil) -> (data:Any?, status:ResponseStatus) {
        
        let response = dataResponse.response?.status?.responseStatus
        
        guard var responseStatus = response else {
            return (nil, status: (type: ResponseType.undefined, description: "Something went wrong, please try again later") )
        }
        switch dataResponse.result {
        case .success:
            if  responseStatus.type == .unauthorized{
                                
//                    let defaults = AppUserDefaults()
//                    defaults.isLoggedIn = false
//                    AppDelegate.getDelegate().setRootController()
                
                return (data:dataResponse.result.value ,status:responseStatus)
            }else if responseStatus.type == .clientError,let responseObject = dataResponse.result.value as? StrAny {
                responseStatus.description = responseObject["error"] as? String ?? responseStatus.description
                return (data:dataResponse.result.value ,status:responseStatus)
            }else{
                return (data:dataResponse.result.value ,status:responseStatus)
            }
        case .failure(let error):
            responseStatus.description = error.localizedDescription
            return (nil,status:responseStatus)
        }
    }*/
    
    class func mimeTypeForPath(url: URL) -> String {
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}
