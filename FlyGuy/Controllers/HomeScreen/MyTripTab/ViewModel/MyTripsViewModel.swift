//
//  UpcomingFlightsViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 08/06/23.
//

import Foundation

class MyTripsViewModel{
    
    var view : BookedFlightListProtocol!
  
    func getBookedFlightListAPI(completion: @escaping (Bool) -> ()) {
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.flightBookingList.rawValue.self
 
        let model = BookingFlightListInputDTO(userID: ViewManager.shared.loginDetails.userID ?? "")
        guard let inputJSON = try? JSONEncoder().encode(model) else{
            return
        }
        Network.sharedInstance.makePostRequestWith(url, postData: inputJSON, useToken: true, delegate: self.view.controller, isBaseUrlRequired : true) { response in
            do {
                let decodedResponse = try JSONDecoder().decode(BookingFlightListOutputDTO.self, from: response)
                self.view.controller.stopSpinner()
                ViewManager.shared.cancelledFlightList = decodedResponse.cancellation
                ViewManager.shared.completedFlightList = decodedResponse.complated
                ViewManager.shared.upcomingFlightList = decodedResponse.upcomming
                self.view.controller.stopSpinner()
                completion(true)

            } catch {
                self.view.controller.stopSpinner()
                print(Messages.noDataFound)
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
}
