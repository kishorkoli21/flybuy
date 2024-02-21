//
//  ConfirmDetailsViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 30/05/23.
//

import Foundation
import UIKit

class ConfirmDetailViewModel {
    
    var view : ConfirmDetailProtocol!
    var destinationList : [ResultBookingCityList]?
    var departureList : [ResultBookingCityList]?
    var arrFareRules : [FareRuleElement]?

 
    
    func getFareRulesApi(Parameters : FareRulesInputDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        let url = API.fareRules.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : false) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(FareRulesOutputDTO.self, from: response)
                self.arrFareRules = decodedResponse.fareRules11Response?.fareRules11Result?.fareRules
                completion(true)
            } catch {
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: Messages.noDataFound)
                   // self.view.controller.view.makeToast(Messages.noDataFound, duration: 2.0, position: .bottom)
                }
                completion(false)
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
            print(error)
            completion(false)
        }
    }
    
    func getFlightBookingApi(Parameters : FlightBookingInputDTO, isDestination : Bool = false,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.flightBooking.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(ConfirmBookingOutputDTO.self, from: response)
                self.view.controller.stopSpinner()
                print("decodedResponse is",decodedResponse)
                if decodedResponse.msg == 1{
                    ViewManager.shared.pnrID = decodedResponse.result?.pnrID ?? ""
                    
                    var param = SendMailInpuDTO()
                    param.pnrID = ViewManager.shared.pnrID
                    
                    self.getSendMailApi(Parameters: param) { isSuccess in
                        print("Send Mail Api Successful")
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.view.controller.showAlert(msg: Messages.noDataFound)
                       // self.view.controller.view.makeToast(Messages.noDataFound, duration: 2.0, position: .bottom)
                    }
                    completion(false)
                }
                completion(true)
            } catch {
                print(Messages.noDataFound)
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: "Error while parsing")
                   // self.view.controller.view.makeToast("Error while parsing", duration: 2.0, position: .bottom)
                    self.view.controller.stopSpinner()
                }
                completion(false)
            }
        } failure: { error in
            self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
                //self.view.controller.view.makeToast(error, duration: 2.0, position: .bottom)
                self.view.controller.stopSpinner()
            }
            print(error)
            completion(false)
        }
        
    }
    
    func getSendMailApi(Parameters : SendMailInpuDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        let url = API.sendMailApi.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response)
                print("decodedResponse is",decodedResponse)
                if decodedResponse.msg == 1{

                }
                else{
                    DispatchQueue.main.async {
                        self.view.controller.showAlert(msg: Messages.noDataFound)
                       // self.view.controller.view.makeToast(Messages.noDataFound, duration: 2.0, position: .bottom)
                    }
                    completion(false)
                }
                completion(true)
            } catch {
                print(Messages.noDataFound)
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: "Error while parsing")
                   // self.view.controller.view.makeToast("Error while parsing", duration: 2.0, position: .bottom)
                }
                completion(false)
            }
        } failure: { error in
            self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
              //  self.view.controller.view.makeToast(error, duration: 2.0, position: .bottom)
            }
            print(error)
            completion(false)
        }
        
    }
    
}


//                if decodedResponse.errors?.errorMessage != nil || decodedResponse.errors?.errorMessage != ""{
//                    VIEWMANAGER.showToast(message: "\(decodedResponse.errors?.errorMessage ?? "") \(decodedResponse.errors?.errorCode ?? "")")
//                }else{
//                    VIEWMANAGER.showToast(message: "Farerules not available.")
//                }
