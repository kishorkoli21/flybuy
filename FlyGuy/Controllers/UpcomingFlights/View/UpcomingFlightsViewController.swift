//
//  UpcomingFlightsViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 18/05/23.
//

import UIKit



class UpcomingFlightsViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblToastMsg: UILabel!
    
    var viemodel = MyTripsViewModel()
    var upcomingFlightList : [Cancellation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            tblView.register(UINib(nibName: "UpcomingFlightCell", bundle: nil), forCellReuseIdentifier: "UpcomingFlightCell")
        }else{
            tblView.register(UINib(nibName: "UpcomeFlightIpadCell", bundle: nil), forCellReuseIdentifier: "UpcomeFlightIpadCell")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let list = ViewManager.shared.upcomingFlightList{
            upcomingFlightList = list
        }
        if VIEWMANAGER.isLogin == false{
            tblView.isHidden = true
            lblToastMsg.isHidden = false
        }else{
            tblView.isHidden = false
            lblToastMsg.isHidden = true
        }
    }
    
    // MARK: Navigation methods
    
    func navigateToSingleFlightDetails(){
        let storyID = UIStoryboard(name: Storyboards.SingleFlightDetailStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.SingleFlightDetailViewController) as! SingleFlightDetailViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToFlightBookingDetails(){
        let storyID = UIStoryboard(name: Storyboards.FlightBookingDetailsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightBookingDetailsViewController) as! FlightBookingDetailsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Button Action methods
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            self.navigationController?.popViewController(animated: true)
        }else{
            self.removeIpad(asChildViewController: self.UpcomingFlightsiPad)
            self.addIpad(asChildViewController: self.MyTripsiPad)
        }
    }
    
}

extension UpcomingFlightsViewController : UITableViewDataSource, UITableViewDelegate{
    
    // MARK: TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingFlightList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingFlightCell") as! UpcomingFlightCell
            let model = upcomingFlightList?[indexPath.row]
            let bookingDetailsModel = model?.bookingDetails
            
            if let bookingDetailsData = bookingDetailsModel?.data(using: String.Encoding.utf8) {
                do {
                    if let bookingDetailsDict = try JSONSerialization.jsonObject(with: bookingDetailsData, options: []) as? [String: Any] {
                        if let from = bookingDetailsDict["from"] as? String, let to = bookingDetailsDict["to"] as? String, let trip = bookingDetailsDict["trip"] as? String {
                            cell.lblOrigin.text = from
                            cell.lblDestination.text = to
                            cell.lblTime.text = model?.journeyDate ?? ""
                            if trip == "oneway"{
                                cell.imgFlightReturn.image = UIImage(named: "Front_Arrow_ICon")
                            }else{
                                cell.imgFlightReturn.image = UIImage(named: "return_Icon")
                            }
                        }
                    }
                } catch {
                    print("Error parsing booking details data: \(error)")
                }
            }
            cell.onSelectViewDetailsClicked {
                let model = self.upcomingFlightList?[indexPath.row]
                ViewManager.shared.pnrID = model?.pnrID ?? ""
                ViewManager.shared.fromScreen = "Upcoming"
                if Constants.deviceType == DeviceType.iPhone.rawValue{
                    self.navigateToFlightBookingDetails()
                }else{
                    self.removeIpad(asChildViewController: self.UpcomingFlightsiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomeFlightIpadCell") as! UpcomeFlightIpadCell
            let model = upcomingFlightList?[indexPath.row]
            let bookingDetailsModel = model?.bookingDetails
            
            if let bookingDetailsData = bookingDetailsModel?.data(using: String.Encoding.utf8) {
                do {
                    if let bookingDetailsDict = try JSONSerialization.jsonObject(with: bookingDetailsData, options: []) as? [String: Any] {
                        if let from = bookingDetailsDict["from"] as? String, let to = bookingDetailsDict["to"] as? String, let trip = bookingDetailsDict["trip"] as? String {
                            cell.lblOrigin.text = from
                            cell.lblDestination.text = to
                            cell.lblTime.text = model?.journeyDate ?? ""
                            if trip == "oneway"{
                                cell.imgFlightReturn.image = UIImage(named: "Front_Arrow_ICon")
                            }else{
                                cell.imgFlightReturn.image = UIImage(named: "return_Icon")
                            }
                        }
                    }
                } catch {
                    print("Error parsing booking details data: \(error)")
                }
            }
            cell.onSelectViewDetailsClicked {
                let model = self.upcomingFlightList?[indexPath.row]
                ViewManager.shared.pnrID = model?.pnrID ?? ""
                ViewManager.shared.fromScreen = "Upcoming"
                if Constants.deviceType == DeviceType.iPhone.rawValue{
                    self.navigateToFlightBookingDetails()
                }else{
                    self.removeIpad(asChildViewController: self.UpcomingFlightsiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = upcomingFlightList?[indexPath.row]
        ViewManager.shared.pnrID = model?.pnrID ?? ""
        ViewManager.shared.fromScreen = "Upcoming"
        ViewManager.shared.isFromCancel = false
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            self.navigateToFlightBookingDetails()
        }else{
            self.removeIpad(asChildViewController: self.UpcomingFlightsiPad)
            self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
        }
    }
    
}


