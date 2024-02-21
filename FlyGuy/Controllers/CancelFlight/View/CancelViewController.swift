//
//  CancelViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 12/06/23.
//

import UIKit

protocol CancelflightProtocol {
    var controller: CancelViewController { get }
}

class CancelViewController: BaseViewController {

    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblRefundAmount: UILabel!
    
    var viewmodel = CancelFlightViewModel()
    var isRefundSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure()
    }
    
    // MARK: Api Integration methods
    
    func configure(){
        viewmodel.view = self
        let model = CancelrefundInputDTO(pnrID: ViewManager.shared.pnrID)
        viewmodel.getFlightRefundDetailApi(Parameters: model) { isSuccess in
            if isSuccess{
                self.isRefundSuccess = true
                var refundAmount: Float = 0.0
                
                if let ptrDetails = self.viewmodel.cancelRefund.result?.ptrResponse?.ptrResult?.ptrDetails {
                    for value in ptrDetails {
                        if let passengers = value.paxDetails {
                            for passenger in passengers {
                                if let totalRefundAmount = Float(passenger.quotedFares?["TotalRefundAmount"]?.amount ?? "0.0") {
                                    refundAmount += totalRefundAmount
                                }
                            }
                        }
                    }
                    if ptrDetails[0].uniqueID != "" {
                        self.lblOrigin.text = self.viewmodel.cancelRefund.ConfirmationNo
                        //"\(ptrDetails[0].uniqueID ?? "")"
                        if ptrDetails[0].ptrStatus == "Completed" {
                            if self.viewmodel.cancelRefund.finalpaymentgetwaycharges == false{
                                self.lblRefundAmount.text = "Refund Amount $0"
                            }else{
                                self.lblRefundAmount.text = "Refund Amount $\(self.viewmodel.cancelRefund.paymentgetwaycharges ?? 0.0)"

//                                if refundAmount > Constants.refundAmountDeductionCharge.floatValue{
//                                    let finalRefundAmount = refundAmount - Constants.refundAmountDeductionCharge.floatValue
//                                    self.lblRefundAmount.text = "Refund Amount $\(String(Constants.refundAmountDeductionCharge.floatValue))"
//                                }else{
//                                    self.lblRefundAmount.text = "Refund Amount $0"
//                                }
                            }
                            if self.viewmodel.cancelRefund.paymentgetwaycharges == nil {
                                ViewManager.shared.refundAmount = "InProcess"
                            }else{
                                ViewManager.shared.refundAmount = "\(self.viewmodel.cancelRefund.paymentgetwaycharges ?? 0.0)"
                            }
                            
                            if self.viewmodel.cancelRefund.refundStatus == 3{
                                ViewManager.shared.refundStatus = "Completed"
                            }else{
                                ViewManager.shared.refundStatus = "InProcess"
                            }
                        }
                    }
                }
                
            }else{
                self.isRefundSuccess = false
                if Constants.deviceType == DeviceType.iPhone.rawValue{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.removeIpad(asChildViewController: self.CancelFlightiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }
        }
    }
    
    func cancelFlightApiConfigure(){
        viewmodel.view = self
        let model = CancelrefundInputDTO(pnrID: ViewManager.shared.pnrID)
        viewmodel.getCancelFlightApi(Parameters: model) { isSuccess in
            if isSuccess{
//                if self.viewmodel.cancelRefund.sum == nil {
//                    ViewManager.shared.refundAmount = "InProcess"
//                }else{
                  //  ViewManager.shared.refundAmount = "\(self.viewmodel.cancelRefund.sum ?? 0.0)"
//                    if self.viewmodel.cancelRefund.is24HoursBefore == true{
//                        ViewManager.shared.refundAmount = "\(self.viewmodel.cancelRefund.sum ?? 0.0)"
//                    }else{
//                        if self.viewmodel.cancelRefund.sum ?? 0.0 > Constants.refundAmountDeductionCharge.floatValue{
//                            let finalRefundAmount = (self.viewmodel.cancelRefund.sum ?? 0.0) - Constants.refundAmountDeductionCharge.floatValue
//                            self.lblRefundAmount.text = "\(String(finalRefundAmount))"
//                        }else{
//                            self.lblRefundAmount.text = "0"
//                        }
//                    }
               // }
                ViewManager.shared.isFromCancel = true
                if Constants.deviceType == DeviceType.iPhone.rawValue{
                    self.navigateToFlightBookingDetails()
                }else{
                    self.removeIpad(asChildViewController: self.UpcomingFlightsiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }else{
                if Constants.deviceType == DeviceType.iPhone.rawValue{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.removeIpad(asChildViewController: self.CancelFlightiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }
        }
    }
    
    // MARK: Navigation methods
  
    func navigateToFlightBookingDetails(){
        let storyID = UIStoryboard(name: Storyboards.FlightBookingDetailsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightBookingDetailsViewController) as! FlightBookingDetailsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    func moveToHomeVCiPad(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeiPadStoryboard, bundle:nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.HomeViewController) as! HomeViewController
        homeVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    // MARK: Button Action methods
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            self.navigationController?.popViewController(animated: true)
        }else{
            self.removeIpad(asChildViewController: self.CancelFlightiPad)
            self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
        }
    }
    
    @IBAction func btnCancelFlightClicked(_ sender: Any) {
        cancelFlightApiConfigure()
    }
}

extension CancelViewController: CancelflightProtocol {
    var controller: CancelViewController {
        self
    }
}
