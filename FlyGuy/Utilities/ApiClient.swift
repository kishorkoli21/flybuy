//
//  ApiClient.swift
//  FlyGuy
//
//  Created by Mac on 05/04/23.
//

import UIKit
import Foundation
import Alamofire


private let BaseURL = Bundle.main.infoDictionary?[Constants.baseURL]

class APIClient: NSObject {
    
    public class var sharedInstance: APIClient {
        struct Singleton {
            static let instance : APIClient = APIClient()
        }
        return Singleton.instance
    }
    
    private func requestURLString(apiName:String) -> String{
        return BaseURL as! String + apiName
    }
    
    private func getHeaders() -> String {
        let user = BasicAuthEnum.Username.rawValue
        let password = BasicAuthEnum.Password.rawValue
        let credentialData = "\(user):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let base64Credentials = credentialData.base64EncodedString()
        return "Basic \(base64Credentials)"
    }
    
    private var session: Alamofire.Session?
    
    private func getSession() -> Alamofire.Session {
        if let session = session {
            return session
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 180
            session = Alamofire.Session(configuration: configuration)
            return session!
        }
    }
    
    func requestGETURL(_ strURL: String,useToken:Bool, delegate:BaseViewController, success:@escaping (AFDataResponse<Any>) -> Void, failure:@escaping (String) -> Void) {
        print("excuting the URL \(strURL)")
        if Connectivity.isConnectedToInternet()
        {
            var headers = HTTPHeaders()
            let auth = "Bearer \(ViewManager.shared.loginDetails.token ?? "")"
            
            headers = [
                ParameterKeys.Authorization: auth,
                ParameterKeys.Accept: ParameterKeys.AcceptValue,
                ParameterKeys.ContentType: ParameterKeys.AcceptValue,
                ParameterKeys.GZip: ParameterKeys.GZipContent
            ]
            
            let finalURL = APIClient().requestURLString(apiName: strURL)
            
            print("final URL \(finalURL)")
            
            AF.request(finalURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).validate().responseJSON { (responseObject) in
                switch responseObject.result {
                case .success :
                    success(responseObject)
                case .failure(let error):
                    print("Error:- \(error)")
                    if let error = responseObject.error {
                        let errorCode: Int = error.responseCode ?? 0
                        if errorCode == 408 {
                            failure(Messages.timeOut)
                        } else {
                            failure(Messages.errMsg)
                        }
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                delegate.view.makeToast(Messages.noInternetConnection)
            }
        }
    }
    
    func requestPOSTURL(_ strURL : String, params : [String : Any]?, useToken:Bool, delegate:BaseViewController, isBaseUrlRequired: Bool = true,success:@escaping (AFDataResponse<Any>) -> Void, failure:@escaping (String) -> Void){
        if Connectivity.isConnectedToInternet()
        {
            
            let auth1 = getHeaders()
            var headers = HTTPHeaders()
            let auth = "Bearer \(ViewManager.shared.loginDetails.token ?? "")"
            
            headers = [
                ParameterKeys.Authorization: strURL == API.reportIncidents.rawValue || strURL == API.getAirlineCode.rawValue ? auth1 : auth,
                ParameterKeys.Accept: ParameterKeys.AcceptValue,
                ParameterKeys.ContentType: ParameterKeys.AcceptValue
            ]
            if isBaseUrlRequired{
                headers.add(name: ParameterKeys.GZip, value: ParameterKeys.GZipContent)
                // ParameterKeys.GZip: ParameterKeys.GZipContent
            }
            
            let finalURL = APIClient().requestURLString(apiName: strURL)
            print("final url is \(finalURL)")
            print("final params is \(String(describing: params))")
            
            AF.request(isBaseUrlRequired == true ? finalURL : strURL, method: .post, parameters: params, encoding: JSONEncoding.prettyPrinted, headers: headers)
                .responseJSON { (responseObject) -> Void in
                    switch responseObject.result {
                    case .success:
                        if let resultDict = responseObject.data,
                           let result = try? JSONSerialization.jsonObject(with: resultDict, options: []) as? [String: Any] {
                            if let message = result["message"] as? String {
                                failure(message)
                            }else if let message = result["Error"] as? String {
                                failure(message)
                            }
                            else if let errors = result["Errors"] as? [String: Any],
                                    let code = errors["ErrorCode"] as? String,
                                    let msg = errors["ErrorMessage"] as? String {
                                failure("\(msg) Error code: \(code)")
                            }else{
                                success(responseObject)
                            }
                        }
                    case .failure(let err):
                        let errorCode: Int = (err as NSError).code
                        if errorCode == 408 || errorCode == 13 {
                            failure(Messages.timeOut)
                        } else {
                            failure(Messages.errMsg)
                        }
                    }
                }
        }else{
            DispatchQueue.main.async {
                delegate.view.makeToast(Messages.noInternetConnection)
            }
        }
    }
    
    
//    func requestDeleteURL(_ strURL : String, success:@escaping (AFDataResponse<Any>) -> Void, failure:@escaping (Error) -> Void){
//        let auth = getHeaders()
//        var headers = HTTPHeaders()
//        headers = [
//            ParameterKeys.Authorization: auth,
//            ParameterKeys.Accept: ParameterKeys.AcceptValue,
//            ParameterKeys.ContentType: ParameterKeys.AcceptValue
//        ]
//        print(headers)
//        print(strURL)
//        AF.request(strURL, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers)
//            .responseJSON { (responseObject) -> Void in
//                switch responseObject.result {
//                case .success:
//                    success(responseObject)
//                case .failure(let err):
//                    failure(err)
//                }
//            }
//    }
    
//    func requestPUTURL(_ strURL : String, params : [String : Any], useToken:Bool, delegate:BaseViewController, success:@escaping (AFDataResponse<Any>) -> Void, failure:@escaping (Error) -> Void){
//
//        if Connectivity.isConnectedToInternet()
//        {
//            let auth = getHeaders()
//            var headers = HTTPHeaders()
//            headers = [
//                ParameterKeys.Authorization: auth,
//                ParameterKeys.Accept: ParameterKeys.AcceptValue,
//                ParameterKeys.ContentType: ParameterKeys.AcceptValue
//            ]
//            let finalURL = APIClient().requestURLString(apiName: strURL)
//
//            print("final url is",finalURL)
//
//            AF.request(finalURL, method: .put, parameters: params, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON { (responseObject) -> Void in
//                print(responseObject)
//                switch responseObject.result {
//                case .success:
//                    success(responseObject)
//                case .failure(let err):
//                    failure(err)
//                }
//            }
//        }else{
//            DispatchQueue.main.async {
//                delegate.view.makeToast(Messages.noInternetConnection)
//            }
//        }
//    }
    
    
    
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
}


import Foundation
import UIKit
import SystemConfiguration
import IQKeyboardManagerSwift

class Network: NSObject
{
    //use either this or
    static let sharedInstance = Network()
    private func requestURLString(apiName:String) -> String{
        return BaseURL as! String + apiName
    }
    private override init()
    {
        super.init()
    }
    
    typealias requestCompletionBlock = (_ dic : Bool,String?,Data?) -> Void
    
    func makePostRequestWith(_ strURL: String, postData: Data, useToken: Bool, delegate: BaseViewController, isBaseUrlRequired: Bool = true, success: @escaping (Data) -> Void, failure: @escaping (String) -> Void) {
        
        let finalURL = requestURLString(apiName: strURL)
        if Connectivity.isConnectedToInternet() {
            //IQKeyBoardManager hide Keyboard
            IQKeyboardManager.shared.resignFirstResponder()
            var request = URLRequest(url: URL(string: isBaseUrlRequired == true ? finalURL : strURL)!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(String(postData.count), forHTTPHeaderField: "Content-Length")
            if isBaseUrlRequired{
                request.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
            }
            request.setValue( "Bearer \(ViewManager.shared.loginDetails.token ?? "")", forHTTPHeaderField: "Authorization")
            request.timeoutInterval = 180
            request.httpBody = postData
            
            getPrintableStringWith(inputOrOutput: true, postData)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            
            let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                print("Response Data: \(String(describing: data))")
                if let dataString = String(data: data ?? Data(), encoding: .utf8) {
                    print("Response Data: \(dataString)")
                }
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data ?? Data(), options: [])
                    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            print("Formatted JSON:\n\(jsonString)")
                        }
                    }
                } catch {
                    let errorCode: Int = (error as NSError).code
                    if errorCode == 408{
                        failure(Messages.timeOut)
                    }else{
                        failure(Messages.errMsg)
                    }
                    print("Error parsing JSON: \(error)")
                }
                if let data = data {
                    self.getPrintableStringWith(inputOrOutput: false, data)
                    DispatchQueue.main.async {
                        do
                        {
                            print("Response Data: \(data)")
                            let resultDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                            if error == nil
                            {
                                if strURL == API.flightBooking.rawValue.self{
                                    if let result = resultDict["msg"]{
                                        if  result as! Int == 1 {
                                            success(data)
                                        }
                                        else {
                                            if let result = resultDict["message"]{
                                                failure(result as! String)
                                            }else if let message = result["Error"] as? String {
                                                failure(message)
                                            }else{
                                                if let result = resultDict["Errors"]{
                                                    if let code = result["ErrorCode"], let msg = result["ErrorMessage"]{
                                                        failure("\(msg ?? "") Error code: \(code ?? "")")
                                                    }
                                                }else if let result = resultDict["Error"] as? [[String: Any]], let firstError = result.first, let errorMessage = firstError["errorMessage"] as? String {
                                                    failure("\(errorMessage)")
                                                }
                                                else{
                                                    failure(Messages.errMsg)
                                                }
                                            }
                                        }
                                    }else{
                                        failure(Messages.errMsg)
                                        // success(data)
                                    }
                                }
//                                else if strURL == API.travelDetails.rawValue.self{
//                                    if let result = resultDict["TripDetailsResponse"]{
//                                        success(data)
//                                    }else{
//                                        failure(Messages.errMsg)
//                                    }
//
//                                }
                                else{
                                    if let result = resultDict["message"], let resultMsg = resultDict["msg"] {
                                        if resultMsg as! Int == 0{
                                            failure(result as! String)
                                        }
                                    }
                                    if let result = resultDict["Errors"]{
                                        if let code = result["ErrorCode"], let msg = result["ErrorMessage"]{
                                            failure("\(msg ?? "") Error code: \(code ?? "")")
                                        }
                                    }else{
                                        success(data)
                                    }
                                }
                            }
                            else
                            {
                                failure(Messages.errMsg)
                            }
                        }
                        catch
                        {
                            failure(Messages.errMsg)
                        }
                    }
                }else {
                    if let error = error as NSError? {
                        let errorCode: Int = error.code
                        if errorCode == 408{
                            failure(Messages.timeOut)
                        }else{
                            failure(Messages.errMsg)
                        }
                    }
                }
            })
            dataTask.resume()
        }else {
            delegate.view.makeToast(Messages.noInternetConnection)
            print("No Internet...")
        }
    }
    
    func getPrintableStringWith(inputOrOutput: Bool, _ data: Data) {
#if DEBUG
        if data.count != 0 {
            //            return
        }
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                let data = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                if let string = String(data: data, encoding: String.Encoding.utf8) {
                    if inputOrOutput {
                        print("REQUEST JSON:\n\(string)")
                    } else {
                        print("RESPONSE JSON:\n\(string)")
                    }
                }
            }
        } catch {
            print(error)
        }
#endif
    }
}

//else if let result = resultDict["Error"]{
//    if let msg = result["errorMessage"]{
//        failure("\(msg ?? "")")
//    }
//}
