//
//  FlightDetailsViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 08/05/23.
//

import UIKit

protocol FlightbookingInboundProtocol {
    var controller: FlightDetailsViewController { get }
}

class FlightDetailsViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var imgReturn: UIImageView!
    
    var selectedFlightDetails = FareItineraries()
    var viewModel = FlightDetailsViewModel()
    var arrCityList : [String]? = []
    var isApicall : Bool = false
    var apiCallScheduled = false


    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFlightDetails = VIEWMANAGER.selectedFlightDetails
        
        if Constants.deviceType == DeviceType.iPad.rawValue{
            tblView.register(UINib(nibName: "FlightDetailsIpadCell", bundle: nil), forCellReuseIdentifier: "FlightDetailsIpadCell")
        }else{
            tblView.register(UINib(nibName: "FlightDetailsCell", bundle: nil), forCellReuseIdentifier: "FlightDetailsCell")
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        lblOrigin.text = ViewManager.shared.journeyRoute.0
        lblDestination.text = ViewManager.shared.journeyRoute.1
        if ViewManager.shared.isReturn{
            imgReturn.image = UIImage(named: "return_Icon")
        }else{
            imgReturn.image = UIImage(named: "Front_Arrow_ICon")
        }

    }

    // MARK: Api integration

    func configure(AirlineCityList: [String],completion: @escaping (Bool) -> ()){
        var model = AirlineCityNameInpuDTO()
        model.airportCode = AirlineCityList
        viewModel.view1 = self
        viewModel.getAirlineCityListApi(Parameters: model) { isSuccess in
            if isSuccess{
                completion(true)
            }else{
                completion(false)
            }
        }
    }

    // MARK: Navigation Methods

    func navigateToTravelerDetails(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: FlightDetailsVCiPad)
            addIpad(asChildViewController: TravelDetailsVCiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.TravelStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.TravelDetailsViewController) as! TravelDetailsViewController
            // vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToCreateAccount(){
        ViewManager.shared.isCreateAccountFromTabBar = false
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: FlightDetailsVCiPad)
            addIpad(asChildViewController: ProfileiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.ProfileStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
            // vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Button Action Methods

    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            navigationController?.popViewController(animated: true)
        }else{
            removeIpad(asChildViewController: FlightDetailsVCiPad)
            addIpad(asChildViewController: ViewManager.shared.isReturn ? FlightListInboundVCiPad : FlightListVCiPad)
        }
    }
    
    @IBAction func btnProceedClicked(_ sender: Any) {
        self.navigateToTravelerDetails()
    }
    
}

extension FlightDetailsViewController : UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    // MARK: TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ViewManager.shared.isReturn ? 2 : 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var originDestinationOptionsModel = FareItineraryOriginDestinationOption()
        if let value = selectedFlightDetails.fareItinerary?.originDestinationOption?[section]{
            originDestinationOptionsModel = value
        }
        let modelInternal = originDestinationOptionsModel.originDestinationOption
        return modelInternal?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var originDestinationOptionsModel = FareItineraryOriginDestinationOption()
        if let value = selectedFlightDetails.fareItinerary?.originDestinationOption?[indexPath.section]{
            originDestinationOptionsModel = value
        }
        if let modelInternal = originDestinationOptionsModel.originDestinationOption?[indexPath.row]{
            if Constants.deviceType == DeviceType.iPad.rawValue{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FlightDetailsIpadCell") as! FlightDetailsIpadCell
                cell.setUpCellData(model: modelInternal)
                cell.lblOrigin.text = modelInternal.flightSegment?.departureAirportLocationCode
                cell.lblDeparture.text = modelInternal.flightSegment?.arrivalAirportLocationCode
//                arrCityList?.append(modelInternal.flightSegment?.arrivalAirportLocationCode ?? "")
//                arrCityList?.append(modelInternal.flightSegment?.departureAirportLocationCode ?? "")
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                    // Call your API here
//                    if self.isApicall == false{
//                        self.configure(AirlineCityList: self.arrCityList ?? [""]) { isSuccess in
//                            if isSuccess{
//                                DispatchQueue.main.async {
//                                    self.tblView.reloadData()
//                                }
//                                if self.arrCityList != [] {
//                                    if self.viewModel.airLineCityListOutput?.count != 0{
//                                        if let airLineCityList = self.viewModel.airLineCityListOutput {
//                                            let filteredAirports = airLineCityList.filter { airport in
//                                                if let airportCode = airport.airportCode {
//                                                    if airportCode == modelInternal.flightSegment?.departureAirportLocationCode{
//                                                        cell.lblOrigin.text = airport.city
//                                                    }
//                                                    if airportCode == modelInternal.flightSegment?.arrivalAirportLocationCode{
//                                                        cell.lblDeparture.text = airport.city
//                                                    }
//                                                }
//                                                self.isApicall = true
//                                                return false
//                                            }
//
//                                        }
//                                    }
//                                }else{
//                                    cell.lblOrigin.text = modelInternal.flightSegment?.departureAirportLocationCode
//                                    cell.lblDeparture.text = modelInternal.flightSegment?.arrivalAirportLocationCode
//                                }
//                            }else{
//                                cell.lblOrigin.text = modelInternal.flightSegment?.departureAirportLocationCode
//                                cell.lblDeparture.text = modelInternal.flightSegment?.arrivalAirportLocationCode
//                            }
//                        }
//                    }
//                }
                
                if(indexPath.row == (originDestinationOptionsModel.originDestinationOption?.count ?? 0) - 1)
                {
                    cell.layoverView.isHidden = true
                }
                cell.lblCabinBaggage.text = selectedFlightDetails.fareItinerary?.airItineraryFareInfo?.fareBreakdown?[0].cabinBaggage?[indexPath.row]
                cell.lblCheckInBaggage.text = selectedFlightDetails.fareItinerary?.airItineraryFareInfo?.fareBreakdown?[0].baggage?[indexPath.row]
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FlightDetailsCell") as! FlightDetailsCell
                cell.setUpCellData(model: modelInternal)
                cell.lblOrigin.text = modelInternal.flightSegment?.departureAirportLocationCode
                cell.lblDeparture.text = modelInternal.flightSegment?.arrivalAirportLocationCode
//                arrCityList?.append(modelInternal.flightSegment?.arrivalAirportLocationCode ?? "")
//                arrCityList?.append(modelInternal.flightSegment?.departureAirportLocationCode ?? "")
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                    // Call your API here
//                    if self.isApicall == false{
//                        self.configure(AirlineCityList: self.arrCityList ?? [""]) { isSuccess in
//                            if isSuccess{
//                                DispatchQueue.main.async {
//                                    self.tblView.reloadData()
//                                }
//                                if self.arrCityList != [] {
//                                    if self.viewModel.airLineCityListOutput?.count != 0{
//                                        if let airLineCityList = self.viewModel.airLineCityListOutput {
//                                            let filteredAirports = airLineCityList.filter { airport in
//                                                if let airportCode = airport.airportCode {
//                                                    if airportCode == modelInternal.flightSegment?.departureAirportLocationCode{
//                                                        cell.lblOrigin.text = airport.city
//                                                    }
//                                                    if airportCode == modelInternal.flightSegment?.arrivalAirportLocationCode{
//                                                        cell.lblDeparture.text = airport.city
//                                                    }
//                                                }
//                                                self.isApicall = true
//                                                return false
//                                            }
//                                        }
//                                    }
//                                }else{
//                                    cell.lblOrigin.text = modelInternal.flightSegment?.departureAirportLocationCode
//                                    cell.lblDeparture.text = modelInternal.flightSegment?.arrivalAirportLocationCode
//                                }
//                            }else{
//                                cell.lblOrigin.text = modelInternal.flightSegment?.departureAirportLocationCode
//                                cell.lblDeparture.text = modelInternal.flightSegment?.arrivalAirportLocationCode
//                            }
//                        }
//                    }
//                }

                if(indexPath.row == (originDestinationOptionsModel.originDestinationOption?.count ?? 0) - 1)
                {
                    cell.layoverView.isHidden = true
                }
                cell.lblCabinBaggage.text = selectedFlightDetails.fareItinerary?.airItineraryFareInfo?.fareBreakdown?[0].cabinBaggage?[indexPath.row]
                cell.lblCheckInBaggage.text = selectedFlightDetails.fareItinerary?.airItineraryFareInfo?.fareBreakdown?[0].baggage?[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 50))
            let titleLabel = UILabel(frame: CGRect(x:0,y: customView.frame.midY - 20 ,width:200,height:30))
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = .black
            titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            titleLabel.text  =  section == 0 ? "Inbound Flight" : "Outbound Flight"
            titleLabel.textAlignment = .left
            customView.addSubview(titleLabel)
            let lineView = UIView(frame: CGRect(x: 0, y: titleLabel.frame.height + 5, width: tableView.frame.width, height: 1))
            lineView.backgroundColor = UIColor.black
            customView.addSubview(lineView)
            return customView
        }else{
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 60))
            let titleLabel = UILabel(frame: CGRect(x:0,y: customView.frame.midY - 20 ,width:300,height:50))
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = .black
            titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            titleLabel.text  = section == 0 ? "Inbound Flight" : "Outbound Flight"
            titleLabel.textAlignment = .left
            customView.addSubview(titleLabel)
            let lineView = UIView(frame: CGRect(x: 0, y: titleLabel.frame.height + 5, width: tableView.frame.width, height: 1))
            lineView.backgroundColor = UIColor.lightGray
            customView.addSubview(lineView)
            return customView
        }
    }

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = ViewManager.shared.isReturn ? 2 : 1
        if section == view - 1 {
            if Constants.deviceType == DeviceType.iPhone.rawValue{
                let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 50))
                customView.addShadow()
                let titleLabel = UILabel(frame: CGRect(x:customView.frame.midX - 100,y: customView.frame.midY - 15 ,width:200,height:30))
                titleLabel.backgroundColor = UIColor.clear
                titleLabel.textColor = .blue
                titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
                let currencyModel = selectedFlightDetails.fareItinerary?.airItineraryFareInfo?.itinTotalFares
                if currencyModel?.totalFare?.currencyCode == "USD"{
                    titleLabel.text = "Price: $\(currencyModel?.totalFare?.amount ?? "-")"
                }else{
                    titleLabel.text = "Price: \(currencyModel?.totalFare?.amount ?? "-")"
                }
                titleLabel.textAlignment = .center
                customView.addSubview(titleLabel)
                return customView
            }else{
                let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 60))
                customView.addShadow()
                let titleLabel = UILabel(frame: CGRect(x:customView.frame.midX - 100,y: customView.frame.midY - 25 ,width:300,height:50))
                titleLabel.backgroundColor = UIColor.clear
                titleLabel.textColor = .blue
                titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
                let currencyModel = selectedFlightDetails.fareItinerary?.airItineraryFareInfo?.itinTotalFares
                if currencyModel?.totalFare?.currencyCode == "USD"{
                    titleLabel.text = "Price: $\(currencyModel?.totalFare?.amount ?? "-")"
                }else{
                    titleLabel.text = "Price: \(currencyModel?.totalFare?.amount ?? "-")"
                }
                titleLabel.textAlignment = .center
                customView.addSubview(titleLabel)
                return customView
            }
        }
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            return 50
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            return 70
        }else{
            return 90
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
           let contentHeight = scrollView.contentSize.height
           let screenHeight = scrollView.frame.size.height

           // Calculate a threshold to trigger the API call, e.g., 80% from the bottom
           let threshold = contentHeight - screenHeight * 0.8

           // Check if user has scrolled near the bottom and an API call isn't already scheduled
           if offsetY > threshold && !apiCallScheduled {
               apiCallScheduled = true
               // Schedule the API call with a delay
               DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                   self.isApicall = false
                   self.arrCityList?.removeAll()
                   self.tblView.reloadData()
               }
           }
    }
    
    
}

extension FlightDetailsViewController: FlightbookingInboundProtocol {
    var controller: FlightDetailsViewController {
        self
    }
 
}
