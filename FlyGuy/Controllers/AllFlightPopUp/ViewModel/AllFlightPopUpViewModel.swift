//
//  AllFlightPopUpViewModel.swift
//  FlyGuy
//
//  Created by Mac on 05/04/23.
//

import Foundation

class AllFlightPopUpViewModel{
    var view : AllFlightPopUpProtocol!
    var airlineCodeList : AirlineCodeModel?
    
    func getAirlineCodeList() {
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.getAirlineCode.rawValue.self
        
        APIClient().requestGETURL(url, useToken: true, delegate: view.controller, success:{ [self] (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(AirlineCodeModel.self, from: response.data!)
                print("decodedResponse is",decodedResponse)
                
                if decodedResponse.count > 0 {
                    DispatchQueue.main.async { [self] in
                        airlineCodeList = decodedResponse
                        view.controller.allAirLineListTableView.reloadData()
                    }
                }else{
                    DispatchQueue.main.async { [self] in
                        airlineCodeList = []
                        view.controller.allAirLineListTableView.reloadData()
                        DispatchQueue.main.async {
                            self.view.controller.view.makeToast(Messages.noDataFound, duration: 2.0, position: .bottom)
                        }
                        
                    }
                }
                self.view.controller.stopSpinner()
 
            } catch {
                self.view.controller.stopSpinner()
            }
            
        }, failure: { (error) in
            self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.view.makeToast(error, duration: 2.0, position: .bottom)
            }
            print(error)
        })
        
    }
}
