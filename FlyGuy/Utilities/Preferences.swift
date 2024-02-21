//
//  Preferences.swift
//  FitnessMaa
//
//  Created by iLoma on 31/12/18.
//  Copyright © 2018 iLoma. All rights reserved.
//

import Foundation
import UIKit
let USER_DEFAULTS  = UserDefaults.standard
class Preferences
{
    class func saveSignUpResponse(response: NSDictionary) {
        let responseData = NSKeyedArchiver.archivedData(withRootObject: response)
        USER_DEFAULTS.set(responseData, forKey: "SignUpResponse")
        USER_DEFAULTS.synchronize()
    }

    class func getSignUpResponse() -> NSDictionary? {
        let loginDict = USER_DEFAULTS.object(forKey: "SignUpResponse")

        if loginDict == nil {
            return nil
        }
        let responseData = NSKeyedUnarchiver.unarchiveObject(with: loginDict as! Data)
        return responseData as? NSDictionary
    }

    class func clearSignUpResponse() {
        USER_DEFAULTS.removeObject(forKey: "SignUpResponse")
        USER_DEFAULTS.synchronize()
    }
    
    class func saveLoginResponse(response: NSDictionary) {
        let responseData = NSKeyedArchiver.archivedData(withRootObject: response)
        USER_DEFAULTS.set(responseData, forKey: "LoginResponse")
        USER_DEFAULTS.synchronize()
    }

    class func getLoginResponse() -> NSDictionary? {
        let loginDict = USER_DEFAULTS.object(forKey: "LoginResponse")

        if loginDict == nil {
            return nil
        }
        let responseData = NSKeyedUnarchiver.unarchiveObject(with: loginDict as! Data)
        return responseData as? NSDictionary
    }

    class func clearLoginResponse() {
        USER_DEFAULTS.removeObject(forKey: "LoginResponse")
        USER_DEFAULTS.synchronize()
    }
    
    class func saveSiriResponse(response: NSDictionary) {
        let responseData = NSKeyedArchiver.archivedData(withRootObject: response)
        USER_DEFAULTS.set(responseData, forKey: "SiriResponse")
        USER_DEFAULTS.synchronize()
    }
//
//    class func saveTokenKey(response: String) {
//         USER_DEFAULTS.set(response, forKey: "TokenKey")
//         USER_DEFAULTS.synchronize()
//     }
//
//     class func getTokenKey() -> String? {
//         let sessionKey = USER_DEFAULTS.object(forKey: "TokenKey")
//         return sessionKey as? String
//     }
//
//     class func clearTokenKey() {
//         USER_DEFAULTS.removeObject(forKey: "TokenKey")
//         USER_DEFAULTS.synchronize()
//     }
//
//    class func saveDeviceToken(token: String) {
//           USER_DEFAULTS.set(token, forKey: "DeviceToken")
//           USER_DEFAULTS.synchronize()
//       }
//
//    class func saveFCMToken(token: String) {
//        USER_DEFAULTS.set(token, forKey: "FCMToken")
//        USER_DEFAULTS.synchronize()
//    }
//
//       class func getADeviceToken() -> String? {
//           let deviceToken = USER_DEFAULTS.object(forKey: "DeviceToken")
//           return deviceToken as? String
//       }
//
//    class func getFCMToken() -> String? {
//        let deviceToken = USER_DEFAULTS.object(forKey: "FCMToken")
//        return deviceToken as? String
//    }
//
    class func getIsFromSiri(response: String){
        USER_DEFAULTS.set(response, forKey: "IsFromSiri")
        USER_DEFAULTS.synchronize()
    }

    class func setIsFromSiri() -> String? {
        let response = USER_DEFAULTS.object(forKey: "IsFromSiri")
        return response as? String
    }


  
}
