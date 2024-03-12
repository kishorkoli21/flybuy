//
//  FlightListInboundViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 24/05/23.
//

import UIKit



class FlightListInboundViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblReturnFlightDate: UILabel!
    @IBOutlet weak var btnSortByPrince: UIButton!
    @IBOutlet weak var btnSortByDatascalp: UIButton!
    @IBOutlet weak var lblMessage: UILabel!

   // var flightDetails = [FareItineraries]()
    var allFlights = [FareItineraries]()
    var filteredFlightsList = [FareItineraries]()
    var ratingsArray = [Ratings]()
    override func viewDidLoad() {
        super.viewDidLoad()
      //  flightDetails.append(ViewManager.shared.selectedFlightDetails)
        var tempArray =   [FareItineraries]()
        tempArray.append((ViewManager.shared.selectedFlightDetails))
        self.allFlights =  tempArray.sorted(by: { Double($0.fareItinerary?.airItineraryFareInfo?.itinTotalFares?.totalFare?.amount ?? "0") ?? 0  < Double($1.fareItinerary?.airItineraryFareInfo?.itinTotalFares?.totalFare?.amount ?? "0") ?? 0
        })
        self.sortRatings()
        self.sortByOptimized()
        self.lblMessage.isHidden = self.filteredFlightsList.count > 0 ? true : false
        self.tblView.reloadData()
        lblReturnFlightDate.text = ViewManager.shared.journeyDate.1

        if Constants.deviceType == DeviceType.iPad.rawValue{
            tblView.register(UINib(nibName: "FlightListIpadCell", bundle: nil), forCellReuseIdentifier: "FlightListIpadCell")
        }else{
            tblView.register(UINib(nibName: "FlightListCellTableViewCell", bundle: nil), forCellReuseIdentifier: "FlightListCellTableViewCell")
        }
        configureDefaultFilters()

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
    
    // MARK: Navigation Methods

    func navigateToFlightDetails(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: FlightListInboundVCiPad)
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
        
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: FlightDetailsVCiPad)
            addIpad(asChildViewController: ProfileiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.ProfileStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
            // vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if let dict = Preferences.getSignUpResponse(){
            let email =  dict["email"] as? String
            if email != "" || email != nil{
                if Constants.deviceType == DeviceType.iPad.rawValue{
                    removeIpad(asChildViewController: FlightListInboundVCiPad)
                    addIpad(asChildViewController: LoginiPad)
                }else{
                    let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
                    let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.LoginViewController) as! LoginViewController
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                if Constants.deviceType == DeviceType.iPad.rawValue{
                    removeIpad(asChildViewController: FlightListInboundVCiPad)
                    addIpad(asChildViewController: ProfileiPad)
                }else{
                    let storyID = UIStoryboard(name: Storyboards.ProfileStoryboard, bundle:nil)
                    let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
                    // vc.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func navigateToTravelerDetails(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: FlightListInboundVCiPad)
            addIpad(asChildViewController: TravelDetailsVCiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.TravelStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.TravelDetailsViewController) as! TravelDetailsViewController
            // vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Button Action Methods
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
            removeIpad(asChildViewController: FlightListInboundVCiPad)
            addIpad(asChildViewController: FlightListVCiPad)
        }
    }
}

extension FlightListInboundViewController: UITableViewDataSource, UITableViewDelegate{
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return filteredFlightsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightListIpadCell") as! FlightListIpadCell
            cell.setUpData(flightDetails: filteredFlightsList[indexPath.row],isReturn: true)
            cell.onSelectViewDetailsClicked {
                if !ViewManager.shared.isLogin{
                    self.navigateToCreateAccount()
                }else{
                    self.navigateToFlightDetails()
                    //navigateToTravelerDetails()
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightListCellTableViewCell") as! FlightListCellTableViewCell
            cell.setUpData(flightDetails: filteredFlightsList[indexPath.row],isReturn: true)
            cell.onSelectViewDetailsClicked {
                if !ViewManager.shared.isLogin{
                    self.navigateToCreateAccount()
                }else{
                    self.navigateToFlightDetails()
                    //navigateToTravelerDetails()
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !ViewManager.shared.isLogin{
            navigateToCreateAccount()
        }else{
            navigateToFlightDetails()
            //navigateToTravelerDetails()
        }
    }
  
}


