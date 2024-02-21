//
//  FlightDetailsViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 16/08/23.
//

import Foundation
import UIKit

class FlightDetailsViewModel {
    
    var airLineCityListOutput : [ResultCityList]?
    var view1 : FlightbookingInboundProtocol!

    
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

    
}
