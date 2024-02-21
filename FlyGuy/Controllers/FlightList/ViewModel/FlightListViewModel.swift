//
//  FlightListViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 30/05/23.
//

import Foundation
import UIKit

class FlightListViewModel {
    var view : validFareProtocol!
    var airLineCityListOutput : [ResultCityList]?
    var view1 : FlightbookingInboundProtocol!

    func getISValidFareApi(fareSourceCode: String, completion: @escaping (Bool) -> ()) {
        let url = API.validFare.rawValue.self
        self.view.controller.view.hideAllToasts()
        let parameters = [
            ParameterKeys.sessionId: ViewManager.shared.flightList.sessionID ?? "",
            ParameterKeys.fareSourceCode: fareSourceCode] as [String : Any]
        self.view.controller.showSpinner()
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.view.controller, isBaseUrlRequired : false) { (response) in
          //  do {
                self.view.controller.stopSpinner()
                if let result = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                    let airRevalidateResponse = result["AirRevalidateResponse"] as? [String: Any]
                    let airRevalidateResult = airRevalidateResponse?["AirRevalidateResult"] as? [String: Any]
                    if let isValid = airRevalidateResult?["IsValid"] as? Bool {
                        if isValid{
                            completion(true)
                        }else{
                            self.view.controller.showAlert(msg: "Searched flight not available.")
                            VIEWMANAGER.isRevalidateErr = true
                            completion(false)
                        }
                    }
                    if let fare = airRevalidateResult?["FareItineraries"] as? [String: Any]{
                        let singleFare = fare["FareItinerary"] as? [String: Any]
                        let isPassportMandatory = singleFare?["IsPassportMandatory"] as? Bool
                        ViewManager.shared.isPassportMandatory = isPassportMandatory ?? false
                    }
                    if let isValid = result["IsValid"] as? String {
                        if isValid == "true"{
                            completion(true)
                        }else{
                            self.view.controller.showAlert(msg: "Searched flight not available.")

                            completion(false)
                        }
                    }
                }
//                let decodedResponse = try JSONDecoder().decode(ValidFareOutputDTO.self, from: response.data!)
//                print("decodedResponse is",decodedResponse)
//                if  ((decodedResponse.airRevalidateResponse?.airRevalidateResult?.isValid) != nil) == true{
//                    completion(true)
//                }else{
//                    VIEWMANAGER.showToast(message: "Searched flight not available.")
//                    completion(false)
//                }
//            } catch {
//                self.view.controller.stopSpinner()
//                VIEWMANAGER.showToast(message: Messages.noDataFound)
//                completion(false)
//            }
        } failure: { (error) in
            self.view.controller.stopSpinner()
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
        self.view1.controller.view.hideAllToasts()
        let url = API.airlineCityList.rawValue.self
        
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view1.controller, isBaseUrlRequired : true) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(AirlineCityListOutputDTO.self, from: response)
                if decodedResponse.msg == 1{
                    self.airLineCityListOutput = decodedResponse.result
                }
                completion(true)
                
            } catch {
                DispatchQueue.main.async {
                    self.view1.controller.showAlert(msg: Messages.noDataFound)
                }
                completion(false)
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.view1.controller.showAlert(msg: error)
            }
            completion(false)
        }
    }

    // MARK: - Get Airline Logo
    func getAirlineLogoApi(validatingAirlineCode : String, completion: @escaping (Bool) -> ()) {
        let url = API.airlineLogoApi.rawValue.self
        //self.view.controller.view.hideAllToasts()
        let parameters = [
            ParameterKeys.airLineCode: validatingAirlineCode] as [String : Any]
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.view.controller, isBaseUrlRequired : false) { (response) in
            if let result = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                let airlineLogoDetailsResponse = result["result"] as? [String: Any]
                if let isValid = result["msg"] as? Bool {
                    if isValid{
                        print(airlineLogoDetailsResponse ?? "")
                        completion(true)
                    }else{
                        self.view.controller.showAlert(msg: "Flight logo not available.")
                        VIEWMANAGER.isRevalidateErr = true
                        completion(false)
                    }
                }
            }
        } failure: { (error) in
            //self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
            completion(false)
        }
    }
}
