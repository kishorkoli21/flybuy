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
    @IBOutlet weak var lblMessage: UILabel!

    var allFlights = [FareItineraries]()
    var filteredFlightsList = [FareItineraries]()
    var ratingsArray = [Ratings]()
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
        if let value = VIEWMANAGER.flightList.result {
            if let allFareItineraries = value.airSearchResult?.fareItineraries {
                self.allFlights =  allFareItineraries.sorted(by: { Double($0.fareItinerary?.airItineraryFareInfo?.itinTotalFares?.totalFare?.amount ?? "0") ?? 0  < Double($1.fareItinerary?.airItineraryFareInfo?.itinTotalFares?.totalFare?.amount ?? "0") ?? 0
                })
            }
            print(self.allFlights.count)
            
           

           
            lblJourneyDate.text = ViewManager.shared.journeyDate.0
            
            self.sortRatings()
            self.sortByOptimized()
            self.lblMessage.isHidden = self.filteredFlightsList.count > 0 ? true : false
            self.tblView.reloadData()
        }
    }
    func sortRatings() {
        if let ratings = VIEWMANAGER.flightList.ratings {
            let filteredRatings = ratings.sorted(by: {
                Double($0.rating ?? "0") ?? 0 > Double($1.rating ?? "0") ?? 0
            })

            for item in filteredRatings {
                if self.ratingsArray.count < 3 {
                    self.ratingsArray.append(item)
                } else {
                    break
                }
            }
        }
    }
    func sortByOptimized() {
        if self.allFlights.count > 0 {
            for rating in ratingsArray {
                for item in allFlights {
                    if item.fareItinerary?.validatingAirlineCode == rating.code {
                        if self.filteredFlightsList.count < 3 {
                            let objects = filteredFlightsList.filter { $0.fareItinerary?.validatingAirlineCode == rating.code}
                            if objects.count == 0 {
                                self.filteredFlightsList.append(item)
                            }
                        } else {
                            break
                        }
                    }
                }
            }
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
            self.filteredFlightsList.removeAll()
            self.filteredFlightsList.append(contentsOf: allFlights.prefix(3))
            break
        case 1:
            self.btnSortByDatascalp.isSelected = !self.btnSortByDatascalp.isSelected
            self.btnSortByPrince.isSelected = false
            self.filteredFlightsList.removeAll()
            self.sortByOptimized()

            break
        default:
            break
        }
        resetFilterStack()
        self.lblMessage.isHidden = self.filteredFlightsList.count > 0 ? true : false
        tblView.reloadData()
        
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
        return filteredFlightsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightListIpadCell") as! FlightListIpadCell
            cell.setUpData(flightDetails: filteredFlightsList[indexPath.row])
            cell.onSelectViewDetailsClicked {
                let model = self.filteredFlightsList[indexPath.row]
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
            cell.setUpData(flightDetails: filteredFlightsList[indexPath.row])
            cell.onSelectViewDetailsClicked {
                let model = self.filteredFlightsList[indexPath.row]
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
        let model = filteredFlightsList[indexPath.row]
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
