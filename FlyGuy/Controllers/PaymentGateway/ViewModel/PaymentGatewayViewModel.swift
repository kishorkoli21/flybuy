//
//  PaymentGatewayViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 26/06/23.
//

import Foundation

import UIKit

class PaymentViewModel {
    
    var view : PaymentProtocol!
    var paymentResponse = PaymentOutputDTO()
    var view1 : PaymentAuthorizeProtocol!
    var authorizePaymentResponse = PaymentAuthorizeOutputDTO()
    
    func getPaymentSessionIdApi(completion: @escaping (Bool) -> ()) {
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.paymentApi.rawValue.self
        
        APIClient().requestGETURL(url.appending(ViewManager.shared.TotalTicketPrice), useToken: true, delegate: view.controller, success:{ [self] (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(PaymentOutputDTO.self, from: response.data!)
                print("decodedResponse is",decodedResponse)
                self.view.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    paymentResponse.result = decodedResponse.result
                    completion(true)
                }else{
                    if decodedResponse.errors?.errorMessage != nil || decodedResponse.errors?.errorMessage != ""{
                        self.view.controller.showAlert(msg:  "\(decodedResponse.errors?.errorMessage ?? "") \(decodedResponse.errors?.errorCode ?? "")")
                    }
                    else if decodedResponse.msg == 0{
                        self.view.controller.showAlert(msg: decodedResponse.result ?? "")
                    }
                    else{
                        self.view.controller.showAlert(msg: Messages.noDataFound)
                    }
                    completion(false)
                }
                
            } catch {
                self.view.controller.stopSpinner()
                self.view.controller.showAlert(msg: Messages.noDataFound)
                completion(false)
            }
            
        }, failure: { (error) in
            self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.view.makeToast(error, duration: 2.0, position: .bottom)
            }
            completion(false)
            print(error)
        })
    }
    
    func getFlightBookingApi(Parameters : FlightBookingInputDTO, isDestination : Bool = false,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view1.controller.view.hideAllToasts()
        self.view1.controller.showSpinner()
        let url = API.flightBooking.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view1.controller) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(ConfirmBookingOutputDTO.self, from: response)
                self.view1.controller.stopSpinner()
                print("decodedResponse is",decodedResponse)
                if decodedResponse.msg == 1{
                    ViewManager.shared.pnrID = decodedResponse.result?.pnrID ?? ""
                    
                    var param = SendMailInpuDTO()
                    param.pnrID = ViewManager.shared.pnrID
                    
                    self.getSendMailApi(Parameters: param) { isSuccess in
                        print("Send Mail Api Successful")
                    }
                    
                    self.getAddAirlinePNRApi(Parameters: ViewManager.shared.pnrID) { isSuccess in
                        print("Add Airline PNR Api Successful")
                    }
                    
                    completion(true)
                }
                else{
                    completion(false)
                }
                
            } catch {
                print(Messages.noDataFound)
                DispatchQueue.main.async {
                    self.view1.controller.showAlert(msg: "Error while parsing")
                    self.view1.controller.stopSpinner()
                }
                completion(false)
            }
        } failure: { error in
            self.view1.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view1.controller.showAlert(msg: error)
                self.view1.controller.stopSpinner()
            }
            print(error)
            completion(false)
        }
        
    }
    
    func getSendMailApi(Parameters : SendMailInpuDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view1.controller.view.hideAllToasts()
        let url = API.sendMailApi.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view1.controller) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response)
                print("decodedResponse is",decodedResponse)
                if decodedResponse.msg == 1{
                    
                }
                else{
                    DispatchQueue.main.async {
                        self.view1.controller.showAlert(msg: Messages.noDataFound)
                    }
                    completion(false)
                }
                completion(true)
            } catch {
                print(Messages.noDataFound)
                DispatchQueue.main.async {
                    self.view1.controller.showAlert(msg: "Error while parsing")
                }
                completion(false)
            }
        } failure: { error in
            self.view1.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view1.controller.showAlert(msg: error)
            }
            print(error)
            completion(false)
        }
        
    }
    
    
    func getVoidPaymentApi(Parameters : VoidPaymentInputDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        let url = API.voidPayment.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : true) { response in
            do {
                self.view.controller.stopSpinner()
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response)
                if decodedResponse.msg == 1{
                    DispatchQueue.main.async {
                        self.view.controller.showAlert(msg: decodedResponse.result ?? "")
                    }
                    completion(true)
                }else{
                    DispatchQueue.main.async {
                        self.view.controller.showAlert(msg: decodedResponse.result ?? "")
                    }
                    completion(false)
                }
            } catch {
                self.view.controller.stopSpinner()
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: Messages.noDataFound)
                }
                completion(false)
            }
        } failure: { error in
            self.view.controller.stopSpinner()
            completion(false)
        }
    }
    
    
    func getAddAirlinePNRApi(Parameters : String,completion: @escaping (Bool) -> ()) {
        self.view1.controller.view.hideAllToasts()
        let url = API.addAirlinePNR.rawValue.self + Parameters
        
        APIClient().requestGETURL(url, useToken: true, delegate: view1.controller, success:{ [self] (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(AddPaymentPNROutputDTO.self, from: response.data!)
                print("decodedResponse is",decodedResponse)
                self.view1.controller.stopSpinner()
                if decodedResponse.msg == 1 {
                    completion(true)
                }else{
                    completion(false)
                }
            } catch {
                self.view1.controller.stopSpinner()
            }
            
        }, failure: { (error) in
            self.view1.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view1.controller.view.makeToast(error, duration: 2.0, position: .bottom)
            }
            print(error)
        })
    }
    
    func getPaymentAuthorizeApi(Parameters : PaymentAuthorizeInputDTO, completion: @escaping (Bool) -> ()) {
        self.view1.controller.view.hideAllToasts()
        self.view1.controller.showSpinner()
        let url = API.authorizePaymentApi.rawValue.self
        
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view1.controller, isBaseUrlRequired : true) { response in
            do {
                self.view1.controller.stopSpinner()
                let decodedResponse = try JSONDecoder().decode(PaymentAuthorizeOutputDTO.self, from: response)
                if decodedResponse.msg == 1{
                    self.authorizePaymentResponse = decodedResponse
                    if decodedResponse.result?.messages?.resultCode == "Error"{
                        if decodedResponse.result?.transactionResponse?.errorsAuthorize?.count ?? 0 > 0 {
                            DispatchQueue.main.async {
                                self.view1.controller.showAlert(msg: decodedResponse.result?.transactionResponse?.errorsAuthorize?[0].errorText ?? "")
                            }
                        }
                        completion(false)
                    }
                    else if decodedResponse.result?.transactionResponse?.messages?[0].code == "1" {
                        completion(true)
                    }
                }else{
                    completion(false)
                }
            } catch {
                self.view1.controller.stopSpinner()
                completion(false)
            }
        } failure: { error in
            self.view1.controller.stopSpinner()
            completion(false)
        }
    }
    
    func getVoidPaymentAuthorizeApi(Parameters : VoidPaymentAuthorizeInputDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view1.controller.view.hideAllToasts()
        let url = API.voidPaymentAuthorize.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view1.controller, isBaseUrlRequired : true) { response in
            do {
                self.view1.controller.stopSpinner()
                let decodedResponse = try JSONDecoder().decode(VoidPaymentAuthorizeOutputDTO.self, from: response)
                if decodedResponse.msg == 1{
                    if decodedResponse.result?.messages?.resultCode == "Error"{
                        DispatchQueue.main.async {
                            self.view1.controller.showAlert(msg: decodedResponse.result?.messages?.message?[0].text ?? "")
                        }
                        completion(false)
                    }
                    else{
                        DispatchQueue.main.async {
                            self.view1.controller.showAlert(msg: decodedResponse.result?.messages?.message?[0].text ?? "")
                        }
                        completion(true)
                    }
                }else{
                    completion(false)
                }
            } catch {
                self.view1.controller.stopSpinner()
                completion(false)
            }
        } failure: { error in
            self.view1.controller.stopSpinner()
            completion(false)
        }
    }
    
    
}

