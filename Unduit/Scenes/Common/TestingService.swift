//
//  TestingService.swift
//  Unduit
//
//  Created by Vivek Patel on 24/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import Foundation
class TestingService: NSObject  {
      //MARK: ApiCall
    func getDiagnosticDeviceTest(callBack:@escaping (_ dashboard:[Category]?,_ error:String?) -> Void)  {
        //print(params)
        APICall.getRequest(url:URL.Test.getDiagnosticDeviceTest, params: nil) { (dataResponse) in
         
          // print("getDiagnosticDeviceTest",dataResponse.result.value)
            let parseResponse = AppUtility.parseResponse(dataResponse)
            guard parseResponse.status == .success, let data = parseResponse.data as?  ArrayType  else{
                callBack(nil,parseResponse.error)
                return
            }
            do{
                let userData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                
                let deviceDiagnostic = try JSONDecoder().decode([Category].self, from: userData)
                
                callBack(deviceDiagnostic,nil)
            }catch(let errorUser){
                callBack(nil,errorUser.localizedDescription)
            }
        }
    }

     func deviceTest(params:StrAny?,callBack:@escaping (_ Code:Bool,_ error:String?) -> Void)  {
               print(params)
        APICall.postRequest(url:URL.Test.deviceTest, params: params) { (dataResponse) in
                 //  print("deviceTest",dataResponse.result.value)
                   let parseResponse = AppUtility.parseResponse(dataResponse)
                   guard parseResponse.status == .success else{
                     callBack(false,parseResponse.error)
                       return
                   }
                   callBack(true,nil)
               }
           }
    
    
    func updateDeviceInfo(params:StrAny?,callBack:@escaping (_ Code:Bool,_ error:String?) -> Void)  {
                  print("updateDeviceInfo:params",params)
           APICall.postRequest(url:URL.Test.updateDeviceInfo, params: params) { (dataResponse) in
                      print("updateDeviceInfo",dataResponse.result.value)
                      let parseResponse = AppUtility.parseResponse(dataResponse)
                      guard parseResponse.status == .success else{
                        callBack(false,parseResponse.error)
                          return
                      }
                      callBack(true,nil)
                  }
              }
     
     func requestQRCode(params:StrAny?,callBack:@escaping (_ Code:Bool,_ error:String?) -> Void)  {
                      print("requestQRCode:params",params)
               APICall.postRequest(url:URL.Scan.requestQRCode, params: params) { (dataResponse) in
                          print("requestQRCode:Responce",dataResponse.result.value)
                          let parseResponse = AppUtility.parseResponse(dataResponse)
                          guard parseResponse.status == .success else{
                            callBack(false,parseResponse.error)
                              return
                          }
                          callBack(true,nil)
                      }
                  }
     
    
}
