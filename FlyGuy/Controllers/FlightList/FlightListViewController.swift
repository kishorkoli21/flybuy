//
//  FlightListViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 02/05/23.
//

import UIKit

protocol validFareProtocol {
    var controller: FlightListViewController { get }
}

class FlightListViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblJourneyDate: UILabel!
    @IBOutlet weak var btnSortByPrince: UIButton!
    @IBOutlet weak var btnSortByDatascalp: UIButton!

    var flightDetails = [Result]()
    var viewModel = FlightListViewModel()
    var airlineLogoDetails = AirlineLogoResult()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Constants.deviceType == DeviceType.iPad.rawValue{
            tblView.register(UINib(nibName: "FlightListIpadCell", bundle: nil), forCellReuseIdentifier: "FlightListIpadCell")
        }else{
            tblView.register(UINib(nibName: "FlightListCellTableViewCell", bundle: nil), forCellReuseIdentifier: "FlightListCellTableViewCell")
        }
        configureDefaultFilters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let value = VIEWMANAGER.flightList.result{
            flightDetails = value
            lblJourneyDate.text = ViewManager.shared.journeyDate.0
            
            /*DispatchQueue.global(qos: .default).async {
                // * Call Get Airline Logo API
                let callAirlineLogoApiCallGroup = DispatchGroup()
                for flightDetailsObj in self.flightDetails {
                    
                    // * api call logic
                    callAirlineLogoApiCallGroup.enter()
                    print(flightDetailsObj.fareItinerary?.validatingAirlineCode ?? "")
                    self.viewModel.view = self
                    self.viewModel.getAirlineLogoApi(validatingAirlineCode: flightDetailsObj.fareItinerary?.validatingAirlineCode ?? "") { isSuccess in
                        if isSuccess{
                            print(isSuccess)
                        }else{
                            print(isSuccess)
                        }
                    }
                    callAirlineLogoApiCallGroup.leave()
                }
                
                callAirlineLogoApiCallGroup.notify(queue: .main) {
                    print("Finished all the API Calls")
                    // * reload the tableview
                }
            }*/
        }
    }
    func configureDefaultFilters() {
        self.btnSortByDatascalp.isSelected = true
        resetFilterStack()
    }
    func resetFilterStack() {
        self.btnSortByPrince.tintColor = self.btnSortByPrince.isSelected ? UIColor().hexStringToUIColor(hex: AppColor.sortBySelectedTextColor) : UIColor().hexStringToUIColor(hex: AppColor.sortByUnSelectedTextColor)
        self.btnSortByDatascalp.tintColor = self.btnSortByDatascalp.isSelected ? UIColor().hexStringToUIColor(hex: AppColor.sortBySelectedTextColor) : UIColor().hexStringToUIColor(hex: AppColor.sortByUnSelectedTextColor)
    }
    
    //MARK: Api integration methods
   
    func configure(fareSourceCode: String, completion: @escaping (Bool) -> ()){
        viewModel.view = self
        viewModel.getISValidFareApi(fareSourceCode: fareSourceCode) { isSuccess in
            if isSuccess{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    // MARK: Navigation Methods
    
    func navigateToFlightInboundList(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: FlightListVCiPad)
            addIpad(asChildViewController: FlightListInboundVCiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.FlightListStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightListInboundViewController) as! FlightListInboundViewController
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToFlightDetails(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: FlightListVCiPad)
            addIpad(asChildViewController: FlightDetailsVCiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.FlightListStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightDetailsViewController) as! FlightDetailsViewController
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToCreateAccount(){
        ViewManager.shared.isCreateAccountFromTabBar = false
        VIEWMANAGER.isFromLoginBtn =  false
        
        if let dict = Preferences.getSignUpResponse(){
            let email =  dict["email"] as? String
            if email != "" || email != nil{
                if Constants.deviceType == DeviceType.iPad.rawValue{
                    removeIpad(asChildViewController: FlightListVCiPad)
                    addIpad(asChildViewController: LoginiPad)
                }else{
                    let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
                    let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.LoginViewController) as! LoginViewController
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                if Constants.deviceType == DeviceType.iPad.rawValue{
                    removeIpad(asChildViewController: FlightListVCiPad)
                    addIpad(asChildViewController: ProfileiPad)
                }else{
                    let storyID = UIStoryboard(name: Storyboards.ProfileStoryboard, bundle:nil)
                    let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
                    // vc.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }else{
            if Constants.deviceType == DeviceType.iPad.rawValue{
                removeIpad(asChildViewController: FlightListVCiPad)
                addIpad(asChildViewController: ProfileiPad)
            }else{
                let storyID = UIStoryboard(name: Storyboards.ProfileStoryboard, bundle:nil)
                let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
                // vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    // MARK: Button Action Methods
    @IBAction func onTapSortBy(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.btnSortByPrince.isSelected = !self.btnSortByPrince.isSelected
            self.btnSortByDatascalp.isSelected = false
            break
        case 1:
            self.btnSortByDatascalp.isSelected = !self.btnSortByDatascalp.isSelected
            self.btnSortByPrince.isSelected = false
            break
        default:
            break
        }
        resetFilterStack()
        
    }
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            navigationController?.popViewController(animated: true)
        }else{
            removeIpad(asChildViewController: FlightListVCiPad)
            addIpad(asChildViewController: BookVCiPad)
        }
    }
}


extension FlightListViewController: UITableViewDataSource, UITableViewDelegate{
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightListIpadCell") as! FlightListIpadCell
            cell.setUpData(flightDetails: flightDetails[indexPath.row])
            cell.onSelectViewDetailsClicked {
                let model = self.flightDetails[indexPath.row]
                self.configure(fareSourceCode: model.fareItinerary?.airItineraryFareInfo?.fareSourceCode ?? "") { isSuccess in
                    ViewManager.shared.fareSourceCode = model.fareItinerary?.airItineraryFareInfo?.fareSourceCode ?? ""
                    if isSuccess{
                        ViewManager.shared.selectedFlightDetails = model
                        
                        if ViewManager.shared.isReturn == true{
                            self.navigateToFlightInboundList()
                        }else{
                            if !ViewManager.shared.isLogin{
                                self.navigateToCreateAccount()
                            }else{
                                self.navigateToFlightDetails()
                                //  self.navigateToTravelerDetails()
                            }
                        }
                    }else{
                        if Constants.deviceType == DeviceType.iPad.rawValue{
                            self.removeIpad(asChildViewController: self.HomeVCiPad)
                            self.addIpad(asChildViewController: self.BookVCiPad)
                        }else{
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightListCellTableViewCell") as! FlightListCellTableViewCell
            cell.indexPath = indexPath
            cell.setUpData(flightDetails: flightDetails[indexPath.row])
            cell.onSelectViewDetailsClicked {
                let model = self.flightDetails[indexPath.row]
                self.configure(fareSourceCode: model.fareItinerary?.airItineraryFareInfo?.fareSourceCode ?? "") { isSuccess in
                    ViewManager.shared.fareSourceCode = model.fareItinerary?.airItineraryFareInfo?.fareSourceCode ?? ""
                    if isSuccess{
                        ViewManager.shared.selectedFlightDetails = model
                        
                        if ViewManager.shared.isReturn == true{
                            self.navigateToFlightInboundList()
                        }else{
                            if !ViewManager.shared.isLogin{
                                self.navigateToCreateAccount()
                            }else{
                                self.navigateToFlightDetails()
                                //  self.navigateToTravelerDetails()
                            }
                        }
                    }else{
                        if Constants.deviceType == DeviceType.iPad.rawValue{
                            self.removeIpad(asChildViewController: self.HomeVCiPad)
                            self.addIpad(asChildViewController: self.BookVCiPad)
                        }else{
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = flightDetails[indexPath.row]
        print(model)
        self.configure(fareSourceCode: model.fareItinerary?.airItineraryFareInfo?.fareSourceCode ?? "") { isSuccess in
            ViewManager.shared.fareSourceCode = model.fareItinerary?.airItineraryFareInfo?.fareSourceCode ?? ""
            if isSuccess{
                ViewManager.shared.selectedFlightDetails = model
                
                if ViewManager.shared.isReturn == true{
                    self.navigateToFlightInboundList()
                }else{
                    if !ViewManager.shared.isLogin{
                        self.navigateToCreateAccount()
                    }else{
                        self.navigateToFlightDetails()
                        //  self.navigateToTravelerDetails()
                    }
                }
            }else{
                if Constants.deviceType == DeviceType.iPad.rawValue{
                    self.removeIpad(asChildViewController: self.HomeVCiPad)
                    self.addIpad(asChildViewController: self.BookVCiPad)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}

extension FlightListViewController: validFareProtocol {
    var controller: FlightListViewController {
        self
    }
}
