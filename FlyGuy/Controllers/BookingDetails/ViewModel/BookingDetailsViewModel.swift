//
//  BookingDetailsViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 23/05/23.
//

import Foundation
import UIKit

struct CityListParameterKeyStruct {
    var city: String?
    //var searchQuery: String?
}

class BookingDetailViewModel {
    
    var view : BookingDetailProtocol!
    var destinationList : [ResultBookingCityList]?
    var departureList : [ResultBookingCityList]?
    var bookingDetailsResult : BookingDetailFareInfos?
    
    func getCityListApi(cityListParameters : CityListParameterKeyStruct, isDestination : Bool = false,completion: @escaping (Bool) -> ()) {
        self.view.controller.view.hideAllToasts()
        //  self.view.controller.showSpinner()
        let url = API.cityList.rawValue.self
        
        let parameters = [
            ParameterKeys.City: cityListParameters.city ?? ""] as [String : Any]
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.view.controller) { (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(BookingDetailsOutputDTO.self, from: response.data!)
                print("decodedResponse is",decodedResponse)
                self.view.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    if decodedResponse.result?.count ?? 0 > 0 {
                        if isDestination{
                            self.destinationList = decodedResponse.result
                        }else{
                            self.departureList = decodedResponse.result
                        }
                    }else{
                        if isDestination{
                            self.destinationList = []
                        }else{
                            self.departureList = []
                        }
                        //                        DispatchQueue.main.async {
                        //                            self.view.controller.showAlert(msg: Messages.noDataFound)
                        //
                        //                        }
                    }
                }else{
                    //   self.view.controller.showAlert(msg: decodedResponse.message ?? "")
                }
                completion(true)
            } catch {
                self.view.controller.stopSpinner()
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: Messages.noDataFound)
                }
                completion(false)
            }
        } failure: { (error) in
            self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
            completion(false)
        }
    }
    
    func getBookingDetailsApi(parameters : BookingDetailsInputDTO,completion: @escaping (Bool) -> ()) {
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.bookingDetailsCheckField.rawValue.self
        
        var trip : String = ""
        var selectedClass : String = ""
        
        if parameters.trip == "One Way Trip"{
            trip = "OneWay"
        }else{
            trip = "Return"
        }
        
        if parameters.classtype == "Business Class"{
            selectedClass = "Business"
        }else{
            selectedClass = "Economy"
        }
        /*
        let parameters = [
            ParameterKeys.trip: trip,
            ParameterKeys.classType: selectedClass,
            ParameterKeys.destination: parameters.destination ?? "",
            ParameterKeys.departure: parameters.departure ?? "",
            ParameterKeys.departureDate: parameters.departureDate ?? "",
            ParameterKeys.departureTime: parameters.departureTime ?? "",
            ParameterKeys.returnDate: parameters.returnDate ?? "",
            ParameterKeys.returnTime: parameters.returnTime ?? "",
            ParameterKeys.adults: parameters.adults ?? "",
            ParameterKeys.childs: parameters.childs ?? "",
            ParameterKeys.infants: parameters.infants ?? ""] as [String : Any]
        */
        let parameters = [
            ParameterKeys.trip: "OneWay",
            ParameterKeys.classType: "Economy",
            ParameterKeys.destination: "STN",
            ParameterKeys.departure: "GLA",
            ParameterKeys.departureDate: "2024-04-20",
            ParameterKeys.departureTime: "05:00 AM",
            ParameterKeys.returnDate: "2024-02-28",
            ParameterKeys.returnTime: "05:00 PM",
            ParameterKeys.adults: "1",
            ParameterKeys.childs: "0",
            ParameterKeys.infants: "0"] as [String : Any]
        
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.view.controller) { (response) in
            
            do {
                let decodedResponse = try JSONDecoder().decode(BookingDetailFareInfos.self, from: response.data!)
                self.view.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    if decodedResponse.result == nil{
                        self.view.controller.stopSpinner()
                        print(Messages.noFlightsFound)
                        DispatchQueue.main.async {
                            self.view.controller.showAlert(msg: Messages.noDataFound)
                        }
                        completion(false)
                    }
                    print("decodedResponse is",decodedResponse)
                    self.bookingDetailsResult = decodedResponse
                    ViewManager.shared.flightList = decodedResponse
                    completion(true)
                }else{
                    self.view.controller.showAlert(msg: decodedResponse.message ?? "")
                }
            } catch {
                self.view.controller.stopSpinner()
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: Messages.noDataFound)
                }
                completion(false)
            }
            
        } failure: { (error) in
            self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
            completion(false)
        }
    }
}
