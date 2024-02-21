//
//  CreateAccountViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 23/05/23.
//

import Foundation
import UIKit

struct SignInParameterKeyStruct {
    var email : String?
    var password : String?
}

struct CreateAccountViewModel{
    
    var view : SignInProtocol!
    var forgotView : ForgotPasswordProtocol!
    var resetView : ResetPasswordProtocol!
    var changeView : ChangePasswordProtocol!
    
    func getSignInDoneAPI(inputParameters : SignInParameterKeyStruct,completion: @escaping (Bool) -> ()) {
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.login.rawValue.self
        
        let parameters = [
            ParameterKeys.email: inputParameters.email ?? "",
            ParameterKeys.password: inputParameters.password ?? "",
        ] as [String : Any]
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.view.controller) { (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(LoginOutputDTO.self, from: response.data!)
                self.view.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    print("decodedResponse is",decodedResponse)
                    self.view.controller.stopSpinner()
                    ViewManager.shared.loginDetails = decodedResponse
                    let dict : NSDictionary = ["firstname": decodedResponse.firstname ?? "",
                                               "lastname": decodedResponse.lastname ?? "",
                                               "email": decodedResponse.email ?? "",
                                               "userId": decodedResponse.userID ?? "",
                                               "number": decodedResponse.phonenumber ?? "",
                                               "token": decodedResponse.token ?? "",
                                               "birthdate" : decodedResponse.birthdate ?? ""
                    ]
                    Preferences.saveLoginResponse(response: dict)
                    self.view.controller.showAlert(msg: decodedResponse.result ?? "")
                }else{
                    self.view.controller.showAlert(msg: decodedResponse.message ?? "")
                }
                completion(true)
            } catch {
                self.view.controller.stopSpinner()
                self.view.controller.showAlert(msg: Messages.noDataFound)
                completion(false)
            }
        } failure: { (error) in
            self.view.controller.stopSpinner()
            self.view.controller.showAlert(msg: error)
            completion(false)
        }
    }
    
    func getForgotPasswordAPI(inputParameters : String,completion: @escaping (Bool) -> ()) {
        self.forgotView.controller.view.hideAllToasts()
        self.forgotView.controller.showSpinner()
        let url = API.forgotPassword.rawValue.self
        
        let parameters = [
            ParameterKeys.email: inputParameters
        ] as [String : Any]
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.forgotView.controller) { (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response.data!)
                self.forgotView.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    completion(true)
                    self.forgotView.controller.showAlert(msg: decodedResponse.result ?? "")
                }else{
                    completion(false)
                    self.forgotView.controller.showAlert(msg: decodedResponse.message ?? "")
                }
            } catch {
                self.forgotView.controller.stopSpinner()
                self.forgotView.controller.showAlert(msg: Messages.noDataFound)
                completion(false)
            }
        } failure: { (error) in
            self.forgotView.controller.stopSpinner()
            self.forgotView.controller.showAlert(msg: error)
            completion(false)
        }
    }
    
    func getResetPasswordAPI(token : String, password : String,repassword : String,completion: @escaping (Bool) -> ()) {
        self.resetView.controller.view.hideAllToasts()
        self.resetView.controller.showSpinner()
        let url = API.resetPassword.rawValue.self
        
        let parameters = [
            ParameterKeys.password: password,
            ParameterKeys.repassword: repassword,
            ParameterKeys.token: token
        ] as [String : Any]
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.resetView.controller) { (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response.data!)
                self.resetView.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    completion(true)
                    self.resetView.controller.showAlert(msg: decodedResponse.result ?? "")
                }else{
                    completion(false)
                    self.resetView.controller.showAlert(msg: decodedResponse.message ?? "")
                }
            } catch {
                self.resetView.controller.stopSpinner()
                self.resetView.controller.showAlert(msg: Messages.noDataFound)
                completion(false)
            }
        } failure: { (error) in
            self.resetView.controller.stopSpinner()
            self.resetView.controller.showAlert(msg: error)
            completion(false)
        }
    }
    
    func getChangePasswordAPI(email : String, password : String, Oldpassword : String,completion: @escaping (Bool) -> ()) {
        self.changeView.controller.view.hideAllToasts()
        self.changeView.controller.showSpinner()
        let url = API.changePassword.rawValue.self
        
        let parameters = [
            ParameterKeys.newpassword: password,
            ParameterKeys.oldpassword: Oldpassword,
            ParameterKeys.email: email
        ] as [String : Any]
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.changeView.controller) { (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response.data!)
                self.changeView.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    completion(true)
                    self.changeView.controller.showAlert(msg: decodedResponse.result ?? "")
                }else{
                    completion(false)
                    self.changeView.controller.showAlert(msg: decodedResponse.message ?? "")
                }
            } catch {
                self.changeView.controller.stopSpinner()
                self.changeView.controller.showAlert(msg: Messages.noDataFound)

                completion(false)
            }
        } failure: { (error) in
            self.changeView.controller.stopSpinner()
            self.changeView.controller.showAlert(msg: error)
            completion(false)
        }
    }
    
}
