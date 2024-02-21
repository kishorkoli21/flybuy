//
//  ProceedCheckoutViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 07/08/23.
//

import Foundation

class ProceedCheckoutViewModel{
    var proceedToCheckoutView : ProceedToCheckoutProtocol!

    func getFlightBookingApi(Parameters : FlightBookingInputDTO, isDestination : Bool = false,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.proceedToCheckoutView.controller.view.hideAllToasts()
        self.proceedToCheckoutView.controller.showSpinner()
        let url = API.flightBooking.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.proceedToCheckoutView.controller) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(ConfirmBookingOutputDTO.self, from: response)
                self.proceedToCheckoutView.controller.stopSpinner()
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
                    self.proceedToCheckoutView.controller.showAlert(msg: "Error while parsing")
                    // self.view.controller.view.makeToast("Error while parsing", duration: 2.0, position: .bottom)
                    self.proceedToCheckoutView.controller.stopSpinner()
                }
                completion(false)
            }
        } failure: { error in
            self.proceedToCheckoutView.controller.stopSpinner()
            DispatchQueue.main.async {
                self.proceedToCheckoutView.controller.showAlert(msg: error)
                //self.view.controller.view.makeToast(error, duration: 2.0, position: .bottom)
                self.proceedToCheckoutView.controller.stopSpinner()
            }
            print(error)
            completion(false)
        }
        
    }
    
    func getAddAirlinePNRApi(Parameters : String,completion: @escaping (Bool) -> ()) {
        self.proceedToCheckoutView.controller.view.hideAllToasts()
        let url = API.addAirlinePNR.rawValue.self + Parameters
        
        APIClient().requestGETURL(url, useToken: true, delegate: proceedToCheckoutView.controller, success:{ [self] (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(AddPaymentPNROutputDTO.self, from: response.data!)
                print("decodedResponse is",decodedResponse)
                self.proceedToCheckoutView.controller.stopSpinner()
                if decodedResponse.msg == 1 {
                    completion(true)
                }else{
                    completion(false)
                }
            } catch {
                self.proceedToCheckoutView.controller.stopSpinner()
            }
            
        }, failure: { (error) in
            self.proceedToCheckoutView.controller.stopSpinner()
            DispatchQueue.main.async {
                self.proceedToCheckoutView.controller.view.makeToast(error, duration: 2.0, position: .bottom)
            }
            print(error)
        })
    }
    
    func getVoidPaymentApi(Parameters : VoidPaymentInputDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.proceedToCheckoutView.controller.view.hideAllToasts()
        let url = API.voidPayment.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.proceedToCheckoutView.controller, isBaseUrlRequired : true) { response in
            do {
                self.proceedToCheckoutView.controller.stopSpinner()
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response)
                if decodedResponse.msg == 1{
                    DispatchQueue.main.async {
                        self.proceedToCheckoutView.controller.showAlert(msg: decodedResponse.result ?? "")
                    }
                    completion(true)
                }else{
                    DispatchQueue.main.async {
                        self.proceedToCheckoutView.controller.showAlert(msg: decodedResponse.result ?? "")
                    }
                    completion(false)
                }
            } catch {
                self.proceedToCheckoutView.controller.stopSpinner()
                DispatchQueue.main.async {
                    self.proceedToCheckoutView.controller.showAlert(msg: Messages.noDataFound)
                }
                completion(false)
            }
        } failure: { error in
            self.proceedToCheckoutView.controller.stopSpinner()
            completion(false)
        }
    }
    
    func getSendMailApi(Parameters : SendMailInpuDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.proceedToCheckoutView.controller.view.hideAllToasts()
        let url = API.sendMailApi.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.proceedToCheckoutView.controller) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response)
                print("decodedResponse is",decodedResponse)
                if decodedResponse.msg == 1{
                    
                }
                else{
                    DispatchQueue.main.async {
                        self.proceedToCheckoutView.controller.showAlert(msg: Messages.noDataFound)
                    }
                    completion(false)
                }
                completion(true)
            } catch {
                print(Messages.noDataFound)
                DispatchQueue.main.async {
                    self.proceedToCheckoutView.controller.showAlert(msg: "Error while parsing")
                }
                completion(false)
            }
        } failure: { error in
            self.proceedToCheckoutView.controller.stopSpinner()
            DispatchQueue.main.async {
                self.proceedToCheckoutView.controller.showAlert(msg: error)
            }
            print(error)
            completion(false)
        }
        
    }
    
    
    func getApplePayPaymentApi(Parameters : PaymentApplePayInputDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.proceedToCheckoutView.controller.view.hideAllToasts()
        let url = API.applePayPaymentApi.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.proceedToCheckoutView.controller) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(PaymentApplePayOutputDTO.self, from: response)
                print("decodedResponse is",decodedResponse)
                if decodedResponse.msg == 1{
                    
                }
                else{
                    DispatchQueue.main.async {
                        self.proceedToCheckoutView.controller.showAlert(msg: Messages.noDataFound)
                    }
                    completion(false)
                }
                completion(true)
            } catch {
                print(Messages.noDataFound)
                DispatchQueue.main.async {
                    self.proceedToCheckoutView.controller.showAlert(msg: "Error while parsing")
                }
                completion(false)
            }
        } failure: { error in
            self.proceedToCheckoutView.controller.stopSpinner()
            DispatchQueue.main.async {
                self.proceedToCheckoutView.controller.showAlert(msg: error)
            }
            print(error)
            completion(false)
        }
        
    }
}
