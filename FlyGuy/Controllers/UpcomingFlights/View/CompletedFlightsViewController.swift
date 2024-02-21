//
//  CompletedFlightsViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 08/06/23.
//

import UIKit

class CompletedFlightsViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblToastMsg: UILabel!
   
    var completedFlightList : [Cancellation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            tblView.register(UINib(nibName: "CompletedFlightCell", bundle: nil), forCellReuseIdentifier: "CompletedFlightCell")
        }else{
            tblView.register(UINib(nibName: "CompletedFlightIpadCell", bundle: nil), forCellReuseIdentifier: "CompletedFlightIpadCell")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let list = ViewManager.shared.completedFlightList{
            completedFlightList = list
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
            self.removeIpad(asChildViewController: self.CompletedFlightsiPad)
            self.addIpad(asChildViewController: self.MyTripsiPad)
        }
    }
    
}

extension CompletedFlightsViewController : UITableViewDataSource, UITableViewDelegate{
    
    // MARK: TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedFlightList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedFlightCell") as! CompletedFlightCell
            let model = completedFlightList?[indexPath.row]
            let bookingDetailsModel = model?.bookingDetails
            
            if let bookingDetailsData = bookingDetailsModel?.data(using: String.Encoding.utf8) {
                do {
                    if let bookingDetailsDict = try JSONSerialization.jsonObject(with: bookingDetailsData, options: []) as? [String: Any] {
                        if let from = bookingDetailsDict["from"] as? String, let to = bookingDetailsDict["to"] as? String, let trip = bookingDetailsDict["trip"] as? String {
                            cell.lblOrigin.text = from
                            cell.lblDestination.text = to
                            cell.btnViewDetails.setTitle("Completed on \(model?.journeyDate ?? "")", for: UIControl.State.normal)
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
                let model = self.completedFlightList?[indexPath.row]
                ViewManager.shared.pnrID = model?.pnrID ?? ""
                ViewManager.shared.fromScreen = "Completed"
                if Constants.deviceType == DeviceType.iPhone.rawValue{
                    self.navigateToFlightBookingDetails()
                }else{
                    self.removeIpad(asChildViewController: self.UpcomingFlightsiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedFlightIpadCell") as! CompletedFlightIpadCell
            let model = completedFlightList?[indexPath.row]
            let bookingDetailsModel = model?.bookingDetails
            
            if let bookingDetailsData = bookingDetailsModel?.data(using: String.Encoding.utf8) {
                do {
                    if let bookingDetailsDict = try JSONSerialization.jsonObject(with: bookingDetailsData, options: []) as? [String: Any] {
                        if let from = bookingDetailsDict["from"] as? String, let to = bookingDetailsDict["to"] as? String, let trip = bookingDetailsDict["trip"] as? String {
                            cell.lblOrigin.text = from
                            cell.lblDestination.text = to
                            cell.btnViewDetails.setTitle("Completed on \(model?.journeyDate ?? "")", for: UIControl.State.normal)
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
                let model = self.completedFlightList?[indexPath.row]
                ViewManager.shared.pnrID = model?.pnrID ?? ""
                ViewManager.shared.fromScreen = "Completed"
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
        let model = completedFlightList?[indexPath.row]
        ViewManager.shared.pnrID = model?.pnrID ?? ""
        ViewManager.shared.fromScreen = "Completed"
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            self.navigateToFlightBookingDetails()
        }else{
            self.removeIpad(asChildViewController: self.UpcomingFlightsiPad)
            self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
        }
    }
}
