//
//  FlightCancellationViewModel.swift
//  FlyGuy
//
//  Created by Mac on 05/04/23.
//

import Foundation
import UIKit

class FlightCancellationViewModel{
    
    var view : FlightCancellationProtocol!
    var airlineCodeList : AirlineCodeModel?
    let databaseInstance = bt_database.instance
    
    
    //MARK: - Api Configuration method
    
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
                        view.controller.airLineDropDownTableView.reloadData()
                    }
                }else{
                    DispatchQueue.main.async { [self] in
                        airlineCodeList = []
                        view.controller.airLineDropDownTableView.reloadData()
                        DispatchQueue.main.async {
                            self.view.controller.showAlert(msg: Messages.noDataFound)

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
                self.view.controller.showAlert(msg: error)
            }
        })
        
    }
    
    func reportIncidents(flightDelayParameters : IncidentsParameterKeyStruct) {
        self.view.controller.view.hideAllToasts()
        self.view.controller.showSpinner()
        let url = API.reportIncidents.rawValue.self
        
        let parameters = [
            ParameterKeys.Issue: flightDelayParameters.issue ?? "",
            ParameterKeys.Difference: flightDelayParameters.difference ?? "",
            ParameterKeys.AirlineName: flightDelayParameters.airlineName ?? "",
            ParameterKeys.ClientIP: flightDelayParameters.clientIP ?? "",
            ParameterKeys.FlightNumber: flightDelayParameters.flightNumber ?? "",
            ParameterKeys.Sum: flightDelayParameters.sum ?? "",
            ParameterKeys.Channel: flightDelayParameters.channel ?? ""] as [String : Any]
        
        print("parameters for reportIncidents",parameters)
        
        APIClient().requestPOSTURL(url, params: parameters, useToken: true, delegate: self.view.controller) { (response) in
            do {
                self.view.controller.stopSpinner()
                let decodedResponse = try JSONDecoder().decode(ReportOutputDTO.self, from: response.data!)
                if decodedResponse.serverResponse == "Auth failed"{
                    self.view.controller.showAlert(msg: Messages.noDataFound)
                    DispatchQueue.main.async { [self] in
                        if Constants.deviceType == DeviceType.iPad.rawValue{
                            view.controller.moveToMainContaineripadVCBase()
                        }else{
                            moveToTabBar()
                        }
                    }
                }else{
                    self.addIncidentToDataBase(issueName: flightDelayParameters.issue ?? "", FlightNumber: flightDelayParameters.flightNumber ?? "", lateness: "")
                    
                    DispatchQueue.main.async { [self] in
                        if Constants.deviceType == DeviceType.iPad.rawValue{
                            view.controller.removeIpad(asChildViewController: view.controller.LostLuggageiPad)
                            view.controller.addIpad(asChildViewController: view.controller.ThankyouiPad)
                            //navigateToThankYouiPadPage()
                        }else{
                            navigateToThankYouPage()
                        }
                    }
                }
            } catch {
                self.view.controller.stopSpinner()
                print(Messages.noDataFound)
                DispatchQueue.main.async {
                    self.view.controller.view.makeToast(Messages.noDataFound, duration: 2.0, position: .bottom)
                }
            }
        } failure: { (error) in
            self.view.controller.stopSpinner()
            DispatchQueue.main.async {
                self.view.controller.showAlert(msg: error)
            }
        }
    }
    
    func addIncidentToDataBase(issueName:String,FlightNumber:String,lateness:String){
        
        var saveIssueName = ""
        var currentDate = ""
        var currentTime = ""
        
        switch issueName{
        case IncidentTypeEnum.CancelledFlight.rawValue:
            saveIssueName = Messages.cancelledFlightTitle
        case IncidentTypeEnum.Baggage.rawValue:
            saveIssueName = Messages.lostLuggageTitle
        case IncidentTypeEnum.LateFlight.rawValue:
            saveIssueName = Messages.delayFlightTitle
        default :
            print(Messages.noDataFound)
        }
        
        currentDate = Date.getCurrentDate()
        currentTime = Date.getCurrentTime()
        
        let addReportIncidentObject = ReportIncidentStruct(flightNumber: FlightNumber, issueName: saveIssueName, reportedOnDate: currentDate, reportedOnTime: currentTime, lateness: lateness)
        
        databaseInstance.addReportIncidentDetails(reportIncidentObject: addReportIncidentObject)
    }
    
    //MARK: - Navigation methods
    
    func navigateToThankYouPage(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.ThankYouStoryboard, bundle:nil)
        let thankYouVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.ThankYouViewController) as! ThankYouViewController
        thankYouVC.hidesBottomBarWhenPushed = true
        self.view.controller.navigationController?.pushViewController(thankYouVC, animated: true)
    }
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.view.controller.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
}
