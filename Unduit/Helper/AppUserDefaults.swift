//
//  AppUserDefaults.swift
//
//  Created by Vivek Patel on 23/01/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

class AppUserDefaults {
    
    private let loggedInKey = "isLoggedIn"
    private let userIdKey = "userId"
    private let passwordKey = "password"
    private let userDataKey = "userData"
    private let qrKey = "qr"
    
    var isLoggedIn:Bool{
        get{
            return Defaults.standard.bool(forKey: loggedInKey)
        }set{
            Defaults.standard.set(newValue, forKey: loggedInKey)
        }
    }
    var userId:String{
        get{
            Defaults.standard.string(forKey: userIdKey) ?? ""
        }set{
            Defaults.standard.set(newValue, forKey: userIdKey)
        }
    }
    var qr:String{
        get{
            Defaults.standard.string(forKey: qrKey) ?? ""
        }set{
            Defaults.standard.set(newValue, forKey: qrKey)
        }
    }
    var password:String{
        get{
            Defaults.standard.string(forKey: passwordKey) ?? ""
        }set{
            Defaults.standard.set(newValue, forKey: passwordKey)
        }
    }
    
    var authorization:String{
      return  userId + ":" + password
    }
    
    /*
    var user:User?{
        get{
            do{
                guard let jsonData  = Defaults.standard.data(forKey: userDataKey) else{
                    return nil
                }
                let userData = try JSONDecoder().decode(User.self, from: jsonData)
                return userData
            }catch{
                return nil
            }
        }set{
            do{
                Defaults.standard.setValue(try JSONEncoder().encode(newValue), forKey: userDataKey)
            }catch{
                Defaults.standard.setValue(nil, forKey: userDataKey)
            }
        }
    }
    var logout:Void{
        Defaults.standard.set(false, forKey: loggedInKey)
    }*/
    
}
