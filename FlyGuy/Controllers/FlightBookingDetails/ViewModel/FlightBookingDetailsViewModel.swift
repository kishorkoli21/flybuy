//
//  FlightBookingDetailsViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 05/06/23.
//

import Foundation
import UIKit

class FlightBookingDetailsViewModel {
    
    var view : FlightbookingDetailDetailProtocol!
    var travelDetailModel = ConfirmBookingDetailOutputDTO()
    var arrFlightList : [ReservationItemElement]?
    var arrPassengerList : [CustomerInfoElement]?
    var arrFareRules : [FareRuleElement]?
    var fareRulesOutput = FareRulesOutputDTO()
    var airportName = String()
    var airLineCityListOutput : [ResultCityList]?
    
    func getFlightBookingDetailApi(Parameters : ConfirmBookingDetailInputDTO, isDestination : Bool = false,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.travelDetailsNew.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : true) { response in
            do {
                VIEWMANAGER.isShowBookingDetailsForIpad = false
                let decodedResponse = try JSONDecoder().decode(ConfirmBookingDetailOutputDTO.self, from: response)
                self.view.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    if decodedResponse.result?.tripDetailsResponse?.tripDetailsResult?.success == "true"{
                    self.travelDetailModel = decodedResponse
                    self.arrFlightList = decodedResponse.result?.tripDetailsResponse?.tripDetailsResult?.travelItinerary?.itineraryInfo?.reservationItems
                    self.arrPassengerList = decodedResponse.result?.tripDetailsResponse?.tripDetailsResult?.travelItinerary?.itineraryInfo?.customerInfos
                }else{
                    if decodedResponse.errors?.errorMessage != nil || decodedResponse.errors?.errorMessage != ""{
                        self.view.controller.showAlert(msg: "\(decodedResponse.errors?.errorMessage ?? "") \(decodedResponse.errors?.errorCode ?? "")")
                    }else{
                        self.view.controller.showAlert(msg: Messages.FlightDetailErr)
                    }
                }
                completion(true)
            }else{
                if decodedResponse.errors?.errorMessage != nil || decodedResponse.errors?.errorMessage != ""{
                    self.view.controller.showAlert(msg: "\(decodedResponse.errors?.errorMessage ?? "") \(decodedResponse.errors?.errorCode ?? "")")
                }else{
                    self.view.controller.showAlert(msg: Messages.FlightDetailErr)
                }
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
            completion(false)
        }
    }
    
    func getFareRulesApi(Parameters : FareRulesInputDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        let url = API.fareRules.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : false) { response in
            do {
                self.view.controller.stopSpinner()
                let decodedResponse = try JSONDecoder().decode(FareRulesOutputDTO.self, from: response)
                self.arrFareRules = decodedResponse.fareRules11Response?.fareRules11Result?.fareRules

                completion(true)
                
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
              //  self.view.controller.showAlert(msg: error)
            }
            completion(false)
        }
    }
  
 
    func getAirlineNameApi(Parameters : AirlineNameInpuDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        let url = API.airLineList.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : true) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response)
                if decodedResponse.msg == 1{
                    self.airportName = decodedResponse.result ?? "-"
                }
                completion(true)
            } catch {
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: Messages.noDataFound)
                }
                completion(false)
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
            completion(false)
        }
    }
    
    func getAirlineCityListApi(Parameters : AirlineCityNameInpuDTO,completion: @escaping (Bool) -> ()) {
        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
            return
        }
        self.view.controller.view.hideAllToasts()
        let url = API.airlineCityList.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : true) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(AirlineCityListOutputDTO.self, from: response)
                if decodedResponse.msg == 1{
                    self.airLineCityListOutput = decodedResponse.result
                }
                completion(true)
                
            } catch {
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: Messages.noDataFound)
                }
                completion(false)
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
            completion(false)
        }
    }

    
}


//
//                if decodedResponse.errors?.errorMessage != nil || decodedResponse.errors?.errorMessage != ""{
//                    VIEWMANAGER.showToast(message: "\(decodedResponse.errors?.errorMessage ?? "") \(decodedResponse.errors?.errorCode ?? "")")
//                }else{
//                    VIEWMANAGER.showToast(message: "Farerules not available.")
//                }
