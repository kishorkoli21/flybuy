//
//  CancelFlightViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 12/06/23.
//

import Foundation
import UIKit

class CancelFlightViewModel {
    
    var view : CancelflightProtocol!
    var cancelRefund = CancelrefundOutputDTO()
    
    func getFlightRefundDetailApi(Parameters : CancelrefundInputDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.flightCancelRefund.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : true) { response in
            do {
                self.view.controller.stopSpinner()
                let decodedResponse = try JSONDecoder().decode(CancelrefundOutputDTO.self, from: response)
                if decodedResponse.msg == 0{
                    DispatchQueue.main.async {
                        self.view.controller.showAlert(msg: decodedResponse.Error ?? "")
                    }
                    completion(false)
                }else{
                    self.cancelRefund = decodedResponse
                    completion(true)
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
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
            print(error)
            completion(false)
        }
    }
    
    func getCancelFlightApi(Parameters : CancelrefundInputDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.cancelFlight.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : true) { response in
            do {
                self.view.controller.stopSpinner()
                let decodedResponse = try JSONDecoder().decode(CancelFlightOutputDTO.self, from: response)
                self.view.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    completion(true)
                }else{
                    self.view.controller.showAlert(msg: decodedResponse.Error ?? "")
                    completion(false)
                }
            } catch {
                do{
                    let decodedResponse = try JSONDecoder().decode(CancelFlightErrorOutputDTO.self, from: response)
                    self.view.controller.stopSpinner()
                    if decodedResponse.msg == 0 && decodedResponse.Error != "" || decodedResponse.Error != nil {
                        self.view.controller.showAlert(msg: decodedResponse.Error ?? "")
                    }else{
                        self.view.controller.showAlert(msg: decodedResponse.result?.errors?.errorMessage ?? "")
                    }
                    completion(false)
                }
                catch{
                    self.view.controller.stopSpinner()
                    DispatchQueue.main.async {
                        self.view.controller.showAlert(msg: Messages.noDataFound)
                    }
                    completion(false)
                }
            }
        } failure: { error in
            self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
            print(error)
            completion(false)
        }
    }
    
    
}
