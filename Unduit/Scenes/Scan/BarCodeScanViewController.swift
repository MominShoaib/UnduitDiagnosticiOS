//
//  BarCodeScanViewController.swift
//  Unduit
//
//  Created by Vivek Patel on 18/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//
import UIKit
import AVFoundation
import swiftScan
import CoreTelephony
import Network
import Reachability
import SystemConfiguration

protocol ScanDelegate {
    func scannedCode(_ code:String)
}
class BarCodeScanViewController:LBXScanViewController,UIPopoverPresentationControllerDelegate{
    //MARK: - Variable
    var topTitle: UILabel?
    var isOpenedFlash: Bool = false
    var bottomItemsView: UIView?
    var btnPhoto: UIButton = UIButton()
    var btnFlash: UIButton = UIButton()
    var btnMyQR: UIButton = UIButton()
    private lazy var presenter = {
        return TestingPresenter(self)
    }()
   
    //MARK: - Outlet
    @IBOutlet weak var viewPreview: UIView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedCodeImage(needCodeImg: true)
        scanStyle?.centerUpOffset = 0 //+= 10
        scanStyle?.isNeedShowRetangle = false
        scanStyle?.colorAngle = .white
        scanStyle?.photoframeAngleStyle = .On
     //   scanStyle?.anmiationStyle = .NetGrid
        scanStyle?.animationImage = #imageLiteral(resourceName: "qrcode_scan_light_green")
        scanStyle?.anmiationStyle = LBXScanViewAnimationStyle.LineMove
        // self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

    }
//    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
//          return false
//      }
    override func viewWillAppear(_ animated: Bool) {
                 self.navigationController?.navigationBar.isHidden = true
                 self.navigationController?.navigationBar.backItem?.hidesBackButton = true
      //  self.navigationController?.navigationBar.barStyle = .blackTranslucent
     }
   
    func getTotalSize() -> Int64?{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last!) {
            if let freeSize = dictionary[FileAttributeKey.systemSize] as? NSNumber {
                return freeSize.int64Value
            }
        }else{
            print("Error Obtaining System Memory Info:")
        }
        return nil
    }
    
    func roundToNearestStorageCapacity(_ storage: Double) -> Double {
        let availableStorageCapacities = [4.0, 8.0, 16.0, 32.0, 64.0, 128.0, 256.0, 512.0, 1024.0]
        return availableStorageCapacities.min(by: { abs($0 - storage) < abs($1 - storage) })!
    }
    
    //MARK: - QRCode Result
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        for result: LBXScanResult in arrayResult {
        
            if let code = result.strScanned {
                let defaults = AppUserDefaults()
                defaults.qr = code
                print(code)
                
                var deviceInfo = DeviceInfoUpdate()
                deviceInfo.deviceManufacturer = "Apple"
                deviceInfo.deviceName =  UIDevice.current.name
                deviceInfo.deviceModel = userDeviceName()
                deviceInfo.deviceVersion = UIDevice.current.systemVersion
                deviceInfo.deviceUuid = (UIDevice.current.identifierForVendor)?.description
                if let total = getTotalSize(){
                    //let storage = Int(Units(bytes: total).gigabytes)
                    let storage = roundToNearestStorageCapacity(Units(bytes: total).gigabytes)
                    deviceInfo.deviceStorage = storage.description + " GB"
                }
                let cellularType:String?
                let telefonyInfo = CTTelephonyNetworkInfo()
                if let radioAccessTechnology = telefonyInfo.currentRadioAccessTechnology{
                    switch radioAccessTechnology{
                    case CTRadioAccessTechnologyLTE: print("LTE (4G)")
                    cellularType = "LTE (4G)"
                    case CTRadioAccessTechnologyWCDMA: print("3G")
                    cellularType = "3G"
                    case CTRadioAccessTechnologyEdge: print("EDGE (2G)")
                    cellularType = "EDGE (2G)"
                    default: print("Other")
                    cellularType = "Not Available"
                    }
                }else{
                    cellularType = "Not Available"
                }
                let ct =  cellularType
                deviceInfo.cellularType = ct
                
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                presenter.apiCallForUpdateDeviceInfo(deviceInfo: deviceInfo)
               
            }
        }
    }
    @IBAction func actionToTest(_ sender: Any) {
        let destination = RightMenuViewController.instantiate(fromStoryboard: .Main)
        self.navigationController?.pushViewController(destination, animated: true)
    }
    //MARK: - Action
    @IBAction func actionPopUp(_ sender: UIBarButtonItem) {
        // get a reference to the view controller for the popover
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popoverId")
        
        // set the presentation style
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        popController.popoverPresentationController?.delegate = self
        //  popController.popoverPresentationController?.sourceView = self.view // button
        popController.popoverPresentationController?.barButtonItem = sender
        popController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 50)
        // present the popover
        self.present(popController, animated: true, completion: nil)
    }
}

extension BarCodeScanViewController:TestingView{
    func successEmail() {}
    
    func getMenuData(_ menuList: [Category]) {}
    
    func testSuccess() {}
    
    func successfullyUpdateInfo() {
        print("successfullyUpdateDeviceInfo")
        let destination = TestQuestionViewController.instantiate(fromStoryboard: .TestCommon)
                                    
      self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func showLoader() {
        showHUD()
    }
    
    func hideLoader() {
         hideHUD()
    }
    
    func showAlert(_ title: String?, message: String?) {
        showAlert(title, message: message, buttonTitle: "Scan Again") {
            self.startScan()
           }
        
    }
    
    
}
/*
 class BarCodeScanViewController:LBXScanViewController, UIPopoverPresentationControllerDelegate {
 var qrCodeFrameView:UIView?
 //MARK: - Variable
 var captureSession: AVCaptureSession!
 var previewLayer: AVCaptureVideoPreviewLayer!
 var delegate:ScanDelegate?
 var vwQRCode:UIView?
 var topTitle: UILabel?
 var isOpenedFlash: Bool = false
 var bottomItemsView: UIView?
 var btnPhoto: UIButton = UIButton()
 var btnFlash: UIButton = UIButton()
 var btnMyQR: UIButton = UIButton()
 //MARK: - Outlet
 @IBOutlet weak var viewPreview: UIView!
 //MARK: - View Life
 override func viewDidLoad() {
 super.viewDidLoad()
 setNeedCodeImage(needCodeImg: true)
 
 //框向上移动10个像素
 scanStyle?.centerUpOffset += 10
 // Initialize QR Code Frame to highlight the QR code
 
 self.navigationController?.navigationBar.backItem?.hidesBackButton = false
 // viewPreview.backgroundColor = UIColor.black
 captureSession = AVCaptureSession()
 
 guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
 let videoInput: AVCaptureDeviceInput
 
 do {
 videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
 } catch {
 return
 }
 
 if (captureSession.canAddInput(videoInput)) {
 captureSession.addInput(videoInput)
 } else {
 failed()
 return
 }
 
 let metadataOutput = AVCaptureMetadataOutput()
 
 if (captureSession.canAddOutput(metadataOutput)) {
 captureSession.addOutput(metadataOutput)
 
 metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
 metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417,.qr]
 } else {
 failed()
 return
 }
 
 previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
 previewLayer.frame = view.layer.bounds
 previewLayer.videoGravity = .resizeAspectFill
 viewPreview.layer.addSublayer(previewLayer)
 
 captureSession.startRunning()
 
 }
 
 override func viewWillAppear(_ animated: Bool) {
 super.viewWillAppear(animated)
 
 if (captureSession?.isRunning == false) {
 captureSession.startRunning()
 }
 }
 
 override func viewWillDisappear(_ animated: Bool) {
 super.viewWillDisappear(animated)
 
 if (captureSession?.isRunning == true) {
 captureSession.stopRunning()
 }
 }
 
 
 
 
 //MARK: - Action
 @IBAction func actionStop(_ sender: Any) {
 dismiss(animated: true, completion: nil)
 }
 
 @IBAction func actionPopUp(_ sender: UIBarButtonItem) {
 // get a reference to the view controller for the popover
 let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popoverId")
 
 // set the presentation style
 popController.modalPresentationStyle = UIModalPresentationStyle.popover
 
 // set up the popover presentation controller
 popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
 popController.popoverPresentationController?.delegate = self
 //  popController.popoverPresentationController?.sourceView = self.view // button
 popController.popoverPresentationController?.barButtonItem = sender
 popController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 50)
 // present the popover
 self.present(popController, animated: true, completion: nil)
 }
 
 // UIPopoverPresentationControllerDelegate method
 func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
 return .none
 }
 
 }
 
 extension BarCodeScanViewController:AVCaptureMetadataOutputObjectsDelegate{
 func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
 
 if let metadataObject = metadataObjects.first {
 guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
 guard let stringValue = readableObject.stringValue else { return }
 AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
 found(code: stringValue)
 captureSession.stopRunning()
 }
 
 dismiss(animated: true)
 }
 }
 //MARK: - Convenience
 extension BarCodeScanViewController{
 func failed() {
 let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
 ac.addAction(UIAlertAction(title: "OK", style: .default))
 present(ac, animated: true)
 captureSession = nil
 }
 func found(code: String) {
 let defaults = AppUserDefaults()
 defaults.qr = code
 //  delegate?.scannedCode(code)
 print(code)
 let destination = DeviceDetailViewController.instantiate(fromStoryboard: .Main)
 
 self.navigationController?.pushViewController(destination, animated: true)
 }
 }
 
 */
