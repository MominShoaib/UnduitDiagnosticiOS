//
//  DeviceInfo.swift
//  Unduit
//
//  Created by Vivek Patel on 03/01/20.
//  Copyright © 2020 VSPLE. All rights reserved.
//

import Foundation
struct DeviceInfoUpdate:Encodable {
    var deviceManufacturer:String?
    var deviceName:String?
    var deviceModel:String?
    var deviceUuid:String?
    var deviceStorage:String?
    var cellularType:String?
    var deviceVersion:String?

    enum CodingKeys:String,CodingKey {
        case deviceManufacturer = "device_manufacturer"
        case deviceName = "device_name"
        case deviceModel = "device_model"
        case deviceUuid = "device_uuid"
        case deviceStorage = "device_storage"
        case cellularType = "cellular_type"
        case deviceVersion = "device_version"
    }
}
