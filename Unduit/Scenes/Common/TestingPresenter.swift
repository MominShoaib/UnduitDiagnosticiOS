//
//  TestingPresenter.swift
//  Unduit
//
//  Created by Vivek Patel on 24/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import Foundation
protocol CommonLoaderView: NSObjectProtocol{
    func showLoader()
    func hideLoader()
    func showAlert(_ title:String?, message:String?)
    func successEmail()
}
protocol TestingView:CommonLoaderView {
    func getMenuData(_ menuList:[Category])
    func testSuccess()
      func successfullyUpdateInfo()
}
class TestingPresenter : NSObject {
    //MARK: - Variable
    weak private var delegate:TestingView?
    
    //MARK: - Life Cycle
    init(_ delegate:TestingView){
        self.delegate = delegate
    }
    
    private lazy var service = {
        return TestingService()
    }()
    
    func apiCallForGetMenuData(){
        delegate?.showLoader()
        service.getDiagnosticDeviceTest { (getMenuData, error) in
            self.delegate?.hideLoader()
            if let error = error{
                self.delegate?.showAlert("Alert", message: error)
            }else{
                self.delegate?.getMenuData(getMenuData!)
            }
        }
    }
    func apiCallForDeviceTest(_ testId:String, testResult:String) {
           delegate?.showLoader()
        let params = ["test_id":testId,"test_result":testResult] as [String : Any]
        service.deviceTest(params: params) { (bool, error) in
               self.delegate?.hideLoader()
               guard error == nil else{
                   self.delegate?.showAlert("Alert", message: error ?? "")
                   return
               }
               self.delegate?.testSuccess()
           }
       }
    func apiCallForUpdateDeviceInfo(deviceInfo:DeviceInfoUpdate) {
             delegate?.showLoader()
        //  let params = ["test_id":testId,"test_result":testResult] as [String : Any]
        service.updateDeviceInfo(params: deviceInfo.dictionary) { (bool, error) in
                 self.delegate?.hideLoader()
                 guard error == nil else{
                     self.delegate?.showAlert("Alert", message: error ?? "")
                     return
                 }
                 self.delegate?.successfullyUpdateInfo()
             }
         }
    func apiCallForRequestQRCode(_ email:String) {
         delegate?.showLoader()
        service.requestQRCode(params: ["email":email]) { (bool, error) in
             self.delegate?.hideLoader()
             guard error == nil else{
                 self.delegate?.showAlert("Alert", message: error ?? "")
                 return
             }
            self.delegate?.successEmail()
         }
     }
    
}
