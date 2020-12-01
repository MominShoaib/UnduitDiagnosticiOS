//
//  Typealiases.swift

//
//  Created by Vivek Patel on 08/01/19.
//  Copyright © 2019 . All rights reserved.
//
/*
import Foundation
import UIKit
import Alamofire

typealias StrAny = [String:Any]
typealias StrAnyOpnl = [String:Any]?
typealias ArrayType = [[String:Any]]
typealias CompletionBlock = (_ dataResponse:DataResponse<Any>) -> Void
typealias CompletionVoid = (_ success:Bool) -> Void
typealias Defaults = UserDefaults
typealias Storyboard = UIStoryboard
typealias TableCell = UITableViewCell
typealias Font = UIFont
typealias Color = UIColor
typealias CollectionCell = UICollectionViewCell
//typealias ResponseStatus = (type: ResponseType, description: String)
typealias ResponseStatus = (data: Any?, error: String?, status:Status)

enum Status {
    case success
    case failure
}
*/

import Foundation
import UIKit
import Alamofire

typealias StrAny = [String:Any]
typealias StrAnyOpnl = [String:Any]?
typealias ArrayType = [[String:Any]]
typealias CompletionBlock = (_ dataResponse:DataResponse<Any>) -> Void
typealias CompletionBlockUpload = (_ dataResponse:DataResponse<Any>?, _ error:String?) -> Void

typealias CompletionVoid = (_ success:Bool, _ error:String?) -> Void
typealias Defaults = UserDefaults
typealias Storyboard = UIStoryboard
typealias TableCell = UITableViewCell
typealias Font = UIFont
typealias Color = UIColor
typealias CollectionCell = UICollectionViewCell
typealias ResponseStatus = (data: Any?, error: String?, status:Status)

enum Status {
    case success
    case failure
}
