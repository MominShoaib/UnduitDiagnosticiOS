//
//  DeviceDetailViewController.swift
//  Unduit
//
//  Created by Vivek Patel on 18/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit
import CoreTelephony
import Network
import Reachability
import SystemConfiguration

import CoreTelephony
public struct Units {
    
    public let bytes: Int64
    
    public var kilobytes: Double {
        return Double(bytes) / 1_024
    }
    
    public var megabytes: Double {
        return kilobytes / 1_024
    }
    
    public var gigabytes: Double {
        return megabytes / 1_024
    }
    
    public init(bytes: Int64) {
        self.bytes = bytes
    }
    
    public func getReadableUnit() -> String {
        
        switch bytes {
        case 0..<1_024:
            return "\(bytes) bytes"
        case 1_024..<(1_024 * 1_024):
            return "\(String(format: "%.2f", kilobytes)) kb"
        case 1_024..<(1_024 * 1_024 * 1_024):
            return "\(String(format: "%.2f", megabytes)) mb"
        case (1_024 * 1_024 * 1_024)...Int64.max:
            return "\(String(format: "%.2f", gigabytes)) gb"
        default:
            return "\(bytes) bytes"
        }
    }
}

struct DeviceSection {
    
    var title:String
    var details:[DeviceDetail] = []
}
struct DeviceDetail {
    
}

class DeviceDetailViewController: UIViewController {//,ENSideMenuDelegate
    var DeviceInfo:DeviceSection?
    private lazy var presenter = {
        return TestingPresenter(self)
    }()
    
    //MARK:- Outlet
    @IBOutlet weak var imgDevice: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTableRadius: UIView!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        viewTableRadius.backgroundColor = UIColor.clear
        viewTableRadius.layer.shadowColor = UIColor.white.cgColor
        viewTableRadius.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewTableRadius.layer.shadowOpacity = 1.0
        viewTableRadius.layer.shadowRadius = 2
        // This is for rounded corners
        self.tableView.layer.cornerRadius = 30
        self.tableView.layer.masksToBounds = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //        self.navigationController?.navigationBar.isHidden = true
        //        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
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
    
    //MARK: - Action
    /*
    @IBAction func actionOpenMenu(_ sender: Any) {  
       panel?.openRight(animated: true)
        guard let right = panel?.right as? RightMenuViewController else{
            return
        }
        right.apiCall()
    }
    */
    @IBAction func unwindeSegueToDeviceDetail(_ sender:UIStoryboardSegue){
    }
}
extension DeviceDetailViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DeviceDetailTableViewCell.self), for: indexPath) as! DeviceDetailTableViewCell
        cell.selectionStyle = .none
        var deviceInfo = DeviceInfoUpdate()
        cell.lblDeviceName.text =  UIDevice.current.name
        cell.lblModel.text =  userDeviceName()
        cell.lblVersion.text = UIDevice.current.systemVersion
        
        deviceInfo.deviceManufacturer = "Apple"
        deviceInfo.deviceName =  UIDevice.current.name
        deviceInfo.deviceModel = userDeviceName()
        deviceInfo.deviceVersion = UIDevice.current.systemVersion
        deviceInfo.deviceUuid = (UIDevice.current.identifierForVendor)?.description
        if let total = getTotalSize(){
            let storage = Int(Units(bytes: total).gigabytes)
            cell.lblStorage.text = storage.description + "GB"
            deviceInfo.deviceStorage = storage.description + "GB"
        }
        
        let telefonyInfo = CTTelephonyNetworkInfo()
        if let radioAccessTechnology = telefonyInfo.currentRadioAccessTechnology{
            switch radioAccessTechnology{
            case CTRadioAccessTechnologyLTE: print("LTE (4G)")
            cell.lblCellularType.text = "LTE (4G)"
            case CTRadioAccessTechnologyWCDMA: print("3G")
            cell.lblCellularType.text = "3G"
            case CTRadioAccessTechnologyEdge: print("EDGE (2G)")
            cell.lblCellularType.text = "EDGE (2G)"
            default: print("Other")
            cell.lblCellularType.text = "Not Available"
            }
        }else{
            cell.lblCellularType.text = "Not Available"
        }
       
        let ct =  cell.lblCellularType.text
        deviceInfo.cellularType = ct
        presenter.apiCallForUpdateDeviceInfo(deviceInfo: deviceInfo)
        
        //   cell.lblIMEI.text = (UIDevice.current.platf)?.description
        return cell
    }
    
}
//MARK: - TableView Delegate
extension DeviceDetailViewController:UITableViewDelegate{
    
    
}

//MARK : -
extension DeviceDetailViewController:TestingView{
    func successEmail() {}
    
    func getMenuData(_ menuList: [Category]) {}
    
    func testSuccess() {}
    
    func successfullyUpdateInfo() {
        print("successfullyUpdateDeviceInfo")
    }
    
    func showLoader() {
        //showHUD()
    }
    
    func hideLoader() {
        // hideHUD()
    }
    
    func showAlert(_ title: String?, message: String?) {
        // showAlert(title, message: message, completion: nil)
    }
    
    
}
class DiskStatus {
    
    //MARK: Formatter MB only
    class func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
    
    //MARK: Get String Value
    class var totalDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    class var freeDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    class var usedDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    
    //MARK: Get raw value
    class var totalDiskSpaceInBytes:Int64 {
        get {
            do {
                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
                return space!
            } catch {
                return 0
            }
        }
    }
    
    class var freeDiskSpaceInBytes:Int64 {
        get {
            do {
                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
                return freeSpace!
            } catch {
                return 0
            }
        }
    }
    
    class var usedDiskSpaceInBytes:Int64 {
        get {
            let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
            return usedSpace
        }
    }
    
}
func userDeviceName() -> String {
    let platform: String = {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0,  count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }()
    
    //iPhone
         if platform == "iPhone1,1"   { return "iPhone" }
    else if platform == "iPhone1,2"   { return "iPhone" }
    else if platform == "iPhone2,1"   { return "iPhone" }
    else if platform == "iPhone3,1"   { return "iPhone" }
    else if platform == "iPhone3,2"   { return "iPhone" }
    else if platform == "iPhone3,3"   { return "iPhone" }
    else if platform == "iPhone4,1"   { return "iPhone" }
    else if platform == "iPhone5,1"   { return "iPhone 5"}
    else if platform == "iPhone5,2"   { return "iPhone 5"}
    else if platform == "iPhone5,3"   { return "iPhone 5c"}
    else if platform == "iPhone5,4"   { return "iPhone 5c"}
    else if platform == "iPhone6,1"   { return "iPhone 5s"}
    else if platform == "iPhone6,2"   { return "iPhone 5s"}
    else if platform == "iPhone7,2"   { return "iPhone 6" }
    else if platform == "iPhone7,1"   { return "iPhone 6 Plus" }
    else if platform == "iPhone8,1"   { return "iPhone 6s" }
    else if platform == "iPhone8,2"   { return "iPhone 6s Plus" }
    else if platform == "iPhone8,4"   { return "iPhone SE" }
    else if platform == "iPhone9,1"   { return "iPhone 7" }
    else if platform == "iPhone9,3"   { return "iPhone 7" }
    else if platform == "iPhone9,2"   { return "iPhone 7 Plus" }
    else if platform == "iPhone9,4"   { return "iPhone 7 Plus" }
    else if platform == "iPhone10,1"  { return "iPhone 8" }
    else if platform == "iPhone10,4"  { return "iPhone 8" }
    else if platform == "iPhone10,2"  { return "iPhone 8 Plus" }
    else if platform == "iPhone10,5"  { return "iPhone 8 Plus" }
    else if platform == "iPhone10,3"  { return "iPhone X" }
    else if platform == "iPhone10,6"  { return "iPhone X" }
    else if platform == "iPhone11,2"  { return "iPhone XS" }
    else if platform == "iPhone11,6"  { return "iPhone XS Max" }
    else if platform == "iPhone11,8"  { return "iPhone XR" }
    else if platform == "iPhone12,1"  { return "iPhone 11" }
    else if platform == "iPhone12,3"  { return "iPhone 11 Pro" }
    else if platform == "iPhone12,5"  { return "iPhone 11 Pro Max" }
        
        //iPod Touch
    else if platform == "iPod1,1"     { return "iPod Touch (1st generation)" }
    else if platform == "iPod2,1"     { return "iPod Touch (2nd generation)" }
    else if platform == "iPod3,1"     { return "iPod Touch (3rd generation)" }
    else if platform == "iPod4,1"     { return "iPod Touch (4th generation)" }
    else if platform == "iPod5,1"     { return "iPod Touch (5th generation)" }
    else if platform == "iPod7,1"     { return "iPod Touch (6th generation)" }
    else if platform == "iPod9,1"     { return "iPod Touch (7th generation)" }
        
        //iPad
    else if platform == "iPad1,1"     { return "iPad (1st generation)" }
    else if platform == "iPad2,1"     { return "iPad 2 (Wi-Fi)" }
    else if platform == "iPad2,2"     { return "iPad 2 (GSM)" }
    else if platform == "iPad2,3"     { return "iPad 2 (CDMA)" }
    else if platform == "iPad2,4"     { return "iPad 2 (Wi-Fi, Mid 2012)" }
    else if platform == "iPad3,1"     { return "iPad (3rd generation) (Wi-Fi)" }
    else if platform == "iPad3,2"     { return "iPad (3rd generation) (GSM+CDMA)" }
    else if platform == "iPad3,3"     { return "iPad (3rd generation) (GSM)" }
    else if platform == "iPad3,4"     { return "iPad (4th generation) (Wi-Fi)"}
    else if platform == "iPad3,5"     { return "iPad (4th generation) (GSM)" }
    else if platform == "iPad3,6"     { return "iPad (4th generation) (GSM+CDMA)" }
    else if platform == "iPad6,11"    { return "iPad (5th generation) (Wi-Fi)" }
    else if platform == "iPad6,12"    { return "iPad (5th generation) (Cellular)" }
    else if platform == "iPad7,5"     { return "iPad (6th generation) (Wi-Fi)" }
    else if platform == "iPad7,6"     { return "iPad (6th generation) (Cellular)" }
    else if platform == "iPad7,11"     { return "iPad (7th generation) (Wi-Fi)" }
    else if platform == "iPad7,12"     { return "iPad (7th generation) (Cellular)" }
        
        //iPad Mini
    else if platform == "iPad2,5"     { return "iPad mini (Wi-Fi)" }
    else if platform == "iPad2,6"     { return "iPad mini (GSM)" }
    else if platform == "iPad2,7"     { return "iPad mini (GSM+CDMA)" }
    else if platform == "iPad4,4"     { return "iPad mini 2 (Wi-Fi)" }
    else if platform == "iPad4,5"     { return "iPad mini 2 (Cellular)" }
    else if platform == "iPad4,6"     { return "iPad mini 2 (China)" }
    else if platform == "iPad4,7"     { return "iPad mini 3 (Wi-Fi)" }
    else if platform == "iPad4,8"     { return "iPad mini 3 (Cellular)" }
    else if platform == "iPad4,9"     { return "iPad mini 3 (China)" }
    else if platform == "iPad5,1"     { return "iPad mini 4 (Wi-Fi)" }
    else if platform == "iPad5,2"     { return "iPad mini 4 (Cellular)" }
    else if platform == "iPad11,1"    { return "iPad mini (5th generation) (Wi-Fi)" }
    else if platform == "iPad11,2"    { return "iPad mini (5th generation)  (Cellular)" }
        
        //iPad Air
    else if platform == "iPad4,1"     { return "iPad Air (Wi-Fi)" }
    else if platform == "iPad4,2"     { return "iPad Air (Cellular)" }
    else if platform == "iPad4,3"     { return "iPad Air (China)" }
    else if platform == "iPad5,3"     { return "iPad Air 2 (Wi-Fi)" }
    else if platform == "iPad5,4"     { return "iPad Air 2 (Cellular)" }
    else if platform == "iPad11,3"    { return "iPad Air (3rd generation) (Wi-Fi)" }
    else if platform == "iPad11,4"    { return "iPad Air (3rd generation) (Cellular)" }
        
        //iPad Pro
    else if platform == "iPad6,3"     { return "iPad Pro 9.7\" (Wi-Fi)" }
    else if platform == "iPad6,4"     { return "iPad Pro 9.7\" (Cellular)" }
    else if platform == "iPad6,7"     { return "iPad Pro 12.9\" (Wi-Fi)" }
    else if platform == "iPad6,8"     { return "iPad Pro 12.9\" (Cellular)" }
    else if platform == "iPad7,1"     { return "iPad Pro 12.9\" (2nd generation) (Wi-Fi)" }
    else if platform == "iPad7,2"     { return "iPad Pro 12.9\" (2nd generation) (Cellular)" }
    else if platform == "iPad7,3"     { return "iPad Pro 10.5\" (Wi-Fi)" }
    else if platform == "iPad7,4"     { return "iPad Pro 10.5\" (Cellular)" }
    else if platform == "iPad8,1"     { return "iPad Pro 11\" (Wi-Fi)" }
    else if platform == "iPad8,2"     { return "iPad Pro 11\" (Wi-Fi, 1TB)" }
    else if platform == "iPad8,3"     { return "iPad Pro 11\" (Cellular)" }
    else if platform == "iPad8,4"     { return "iPad Pro 11\" (Cellular 1TB)" }
    else if platform == "iPad8,5"     { return "iPad Pro 12.9\" (3rd generation) (Wi-Fi)" }
    else if platform == "iPad8,6"     { return "iPad Pro 12.9\" (3rd generation) (Cellular)" }
    else if platform == "iPad8,7"     { return "iPad Pro 12.9\" (3rd generation) (Wi-Fi, 1TB)" }
    else if platform == "iPad8,8"     { return "iPad Pro 12.9\" (3rd generation) (Cellular, 1TB)" }
        
        //Apple TV
    else if platform == "AppleTV2,1"  { return "Apple TV 2G" }
    else if platform == "AppleTV3,1"  { return "Apple TV 3" }
    else if platform == "AppleTV3,2"  { return "Apple TV 3 (2013)" }
    else if platform == "AppleTV5,3"  { return "Apple TV 4" }
    else if platform == "AppleTV6,2"  { return "Apple TV 4K" }
        
        //Apple Watch
    else if platform == "Watch1,1"    { return "Apple Watch (1st generation) (38mm)" }
    else if platform == "Watch1,2"    { return "Apple Watch (1st generation) (42mm)" }
    else if platform == "Watch2,6"    { return "Apple Watch Series 1 (38mm)" }
    else if platform == "Watch2,7"    { return "Apple Watch Series 1 (42mm)" }
    else if platform == "Watch2,3"    { return "Apple Watch Series 2 (38mm)" }
    else if platform == "Watch2,4"    { return "Apple Watch Series 2 (42mm)" }
    else if platform == "Watch3,1"    { return "Apple Watch Series 3 (38mm Cellular)" }
    else if platform == "Watch3,2"    { return "Apple Watch Series 3 (42mm Cellular)" }
    else if platform == "Watch3,3"    { return "Apple Watch Series 3 (38mm)" }
    else if platform == "Watch3,4"    { return "Apple Watch Series 3 (42mm)" }
    else if platform == "Watch4,1"    { return "Apple Watch Series 4 (40mm)" }
    else if platform == "Watch4,2"    { return "Apple Watch Series 4 (44mm)" }
    else if platform == "Watch4,3"    { return "Apple Watch Series 4 (40mm Cellular)" }
    else if platform == "Watch4,4"    { return "Apple Watch Series 4 (44mm Cellular)" }
        //else if platform == "Watch"    { return "Apple Watch Series 5 (40mm)" } //5,1?
        //else if platform == "Watch"    { return "Apple Watch Series 5 (44mm)" } //5,2?
        //else if platform == "Watch"    { return "Apple Watch Series 5 (40mm Cellular)" } //5,3?
        //else if platform == "Watch"    { return "Apple Watch Series 5 (44mm Cellular)" } //5,4?
        
        //Simulator
    else if platform == "i386"        { return "Simulator" }
    else if platform == "x86_64"      { return "Simulator"}
    
    return platform
}

extension DeviceDetailViewController{
    
    /*
     func isConnectedToNetwork() -> Bool {
     
     var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
     zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
     zeroAddress.sin_family = sa_family_t(AF_INET)
     
     let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
     SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
     }
     
     var flags: SCNetworkReachabilityFlags = []
     if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
     return false;
     }
     
     let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
     let isWWAN = (flags & UInt32(kSCNetworkReachabilityFlagsIsWWAN)) != 0
     
     if(isReachable || isWWAN){
     // Have connection
     if (isWWAN){
     // Setup the Network Info and create a CTCarrier object
     var networkInfo = CTTelephonyNetworkInfo()
     var carrier = networkInfo.subscriberCellularProvider
     
     // Get carrier name
     var carrierName = carrier?.carrierName
     }
     
     return true
     }
     return false;
     }
     */
}
/*
 
 
 extension DeviceDetailViewController{
 // MARK: - ENSideMenu Delegate
 func sideMenuWillOpen() {
 
 print("sideMenuWillOpen")
 }
 
 func sideMenuWillClose() {
 print("sideMenuWillClose")
 }
 
 func sideMenuShouldOpenSideMenu() -> Bool {
 print("sideMenuShouldOpenSideMenu")
 return true
 }
 
 func sideMenuDidClose() {
 print("sideMenuDidClose")
 }
 
 func sideMenuDidOpen() {
 print("sideMenuDidOpen")
 }
 }
 */
