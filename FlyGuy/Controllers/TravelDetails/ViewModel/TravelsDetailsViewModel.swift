//
//  TravelsDetailsViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 04/07/23.
//

import Foundation
import UIKit

class TravelDetailsViewModel {
    
//    var view : TravelDetailProtocol!
//   // var travelDetailModel = ConfirmBookingDetailOutputDTO()
//    var airportName = String()
// 
//    func getAirlineNameApi(Parameters : String,completion: @escaping (Bool) -> ()) {
//        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
//            return
//        }
//        self.view.controller.view.hideAllToasts()
//        let url = API.airLineList.rawValue.self
//        
//        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : false) { response in
//            do {
//                self.view.controller.stopSpinner()
//                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response)
//                if decodedResponse.msg == 1{
//                    self.airportName = decodedResponse.result ?? "-"
//                }else{
//                    self.airportName = "-"
//                }
//                completion(true)
//                
//            } catch {
//                self.view.controller.stopSpinner()
//                print(Messages.noDataFound)
//                DispatchQueue.main.async {
//                    self.view.controller.view.makeToast(Messages.noDataFound, duration: 2.0, position: .bottom)
//                }
//                completion(false)
//            }
//        } failure: { error in
//            self.view.controller.stopSpinner()
//            DispatchQueue.main.async {
//                self.view.controller.view.makeToast(error, duration: 2.0, position: .bottom)
//            }
//            print(error)
//            completion(false)
//        }
//    }
//    
//    func getAirlineCityListApi(Parameters : [String],completion: @escaping (Bool) -> ()) {
//        guard let inputJSON = try? JSONEncoder().encode(Parameters) else{
//            return
//        }
//        self.view.controller.view.hideAllToasts()
//        let url = API.airLineList.rawValue.self
//        
//        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : false) { response in
//            do {
//                self.view.controller.stopSpinner()
//                let decodedResponse = try JSONDecoder().decode(ForgotPasswordOutputDTO.self, from: response)
//                if decodedResponse.msg == 1{
//                    self.airportName = decodedResponse.result ?? "-"
//                }else{
//                    self.airportName = "-"
//                }
//                completion(true)
//                
//            } catch {
//                self.view.controller.stopSpinner()
//                print(Messages.noDataFound)
//                DispatchQueue.main.async {
//                    self.view.controller.view.makeToast(Messages.noDataFound, duration: 2.0, position: .bottom)
//                }
//                completion(false)
//            }
//        } failure: { error in
//            self.view.controller.stopSpinner()
//            DispatchQueue.main.async {
//                self.view.controller.view.makeToast(error, duration: 2.0, position: .bottom)
//            }
//            print(error)
//            completion(false)
//        }
//    }

    
}
