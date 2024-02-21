//
//  ProfileViewModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 19/05/23.
//

import Foundation
import UIKit

struct SignUpParameterKeyStruct {
    var firstname : String?
    var lastname : String?
    var email : String?
    var password : String?
    var phonenumber : String?
    var dob : String?
}

class ProfileViewModel{
    
    var view : SignUpProtocol!
    
    func getSignUpDoneAPI(inputParameters : SignUpParameterKeyStruct,completion: @escaping (Bool) -> ()) {
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.signup.rawValue.self
        
        let parameters = [
            ParameterKeys.firstname: inputParameters.firstname ?? "",
            ParameterKeys.lastname: inputParameters.lastname ?? "",
            ParameterKeys.email: inputParameters.email ?? "",
            ParameterKeys.password: inputParameters.password ?? "",
            ParameterKeys.phonenumber: inputParameters.phonenumber ?? "",
            ParameterKeys.repassword: inputParameters.password ?? "",
            ParameterKeys.birthdate: inputParameters.dob ?? ""
            
        ] as [String : Any]
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.view.controller) { (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(SignInOutputDTO.self, from: response.data!)
                if decodedResponse.msg == 1{
                    print("decodedResponse is",decodedResponse)
                    self.view.controller.stopSpinner()
                    self.view.controller.showAlert(msg: decodedResponse.result ?? "")
                    completion(true)
                }else{
                    self.view.controller.showAlert(msg: decodedResponse.message ?? "")
                    self.view.controller.stopSpinner()
                    completion(false)
                }
                
            } catch {
                self.view.controller.stopSpinner()
                self.view.controller.showAlert(msg: Messages.noDataFound)
                print(Messages.noDataFound)
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: Messages.noDataFound)
                }
                completion(false)
            }
        } failure: { (error) in
            self.view.controller.stopSpinner()
            print(error)
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)

            }
            completion(false)
        }
    }
    
    func getProfileUpdateDoneAPI(inputParameters : SignUpParameterKeyStruct,completion: @escaping (Bool) -> ()) {
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.profileUpdate.rawValue.self
        
        let parameters = [
            ParameterKeys.firstname: inputParameters.firstname ?? "",
            ParameterKeys.lastname: inputParameters.lastname ?? "",
            ParameterKeys.email: inputParameters.email ?? "",
            ParameterKeys.phonenumber: inputParameters.phonenumber ?? "",
            ParameterKeys.birthdate: inputParameters.dob ?? ""
        ] as [String : Any]
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.view.controller) { (response) in
            do {
                let decodedResponse = try JSONDecoder().decode(SignInOutputDTO.self, from: response.data!)
                self.view.controller.stopSpinner()
                if decodedResponse.msg == 1{
                    print("decodedResponse is",decodedResponse)
                    self.view.controller.showAlert(msg: decodedResponse.result ?? "")

                }else{
                    self.view.controller.showAlert(msg: decodedResponse.message ?? "")

                }
                completion(true)
            } catch {
                self.view.controller.stopSpinner()
                DispatchQueue.main.async {
                    self.view.controller.showAlert(msg: Messages.noDataFound)

                }
                print(Messages.noDataFound)
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



//    func addIncidentToDataBase(issueName:String,FlightNumber:String,lateness:String){
//
//        var saveIssueName = ""
//        var currentDate = ""
//        var currentTime = ""
//
//        switch issueName{
//        case IncidentTypeEnum.CancelledFlight.rawValue:
//            saveIssueName = Messages.cancelledFlightTitle
//        case IncidentTypeEnum.Baggage.rawValue:
//            saveIssueName = Messages.lostLuggageTitle
//        case IncidentTypeEnum.LateFlight.rawValue:
//            saveIssueName = Messages.delayFlightTitle
//        default :
//            print(Messages.noDataFound)
//        }
//
//        currentDate = Date.getCurrentDate()
//        currentTime = Date.getCurrentTime()
//
//        var addReportIncidentObject = ReportIncidentStruct(flightNumber: FlightNumber, issueName: saveIssueName, reportedOnDate: currentDate, reportedOnTime: currentTime, lateness: lateness)
//
//        databaseInstance.addReportIncidentDetails(reportIncidentObject: addReportIncidentObject)
//    }

