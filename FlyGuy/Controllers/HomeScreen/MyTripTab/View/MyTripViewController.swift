//
//  MyTripViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 18/05/23.
//

import UIKit

protocol BookedFlightListProtocol {
    var controller: MyTripViewController { get }
}

class MyTripViewController: BaseViewController {

    @IBOutlet weak var BGViewUpcoming: UIView!
    @IBOutlet weak var BGViewCancelled: UIView!
    @IBOutlet weak var BGViewCompleted: UIView!
    
    var viemodel = MyTripsViewModel()
    var isSuccess : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BGViewUpcoming.addShadowForCell()
        BGViewCancelled.addShadowForCell()
        BGViewCompleted.addShadowForCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure()
//        if VIEWMANAGER.isLogin == false{
//            BGViewUpcoming.isHidden = true
//            BGViewCancelled.isHidden = true
//            BGViewCompleted.isHidden = true
//            let alertController = UIAlertController(title: "Login", message: "You are not login yet. Please login to continue.", preferredStyle: .alert)
//            let OKAction = UIAlertAction(title: "OK", style: .default) {
//                (action: UIAlertAction!) in
//                print("Ok button tapped");
//            }
//            alertController.addAction(OKAction)
//            self.present(alertController, animated: true, completion: nil)
//        }else{
//            BGViewUpcoming.isHidden = false
//            BGViewCancelled.isHidden = false
//            BGViewCompleted.isHidden = false
//            configure()
//        }
    }
    
    // MARK: Api integration

    func configure(){
        viemodel.view = self
        viemodel.getBookedFlightListAPI { isSuccess in
            if isSuccess{
                self.isSuccess = true
                self.stopSpinner()
            }else{
                self.isSuccess = false
                self.stopSpinner()
            }
        }
    }
    
    // MARK: Navigation methods
    
    func navigateToUpcomingFlights(){
        let storyID = UIStoryboard(name: Storyboards.UpcomingFlightsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.UpcomingFlightsViewController) as! UpcomingFlightsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToCancelledFlights(){
        let storyID = UIStoryboard(name: Storyboards.UpcomingFlightsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.CancelledFlightViewController) as! CancelledFlightViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToCompletedFlights(){
        let storyID = UIStoryboard(name: Storyboards.UpcomingFlightsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.CompletedFlightsViewController) as! CompletedFlightsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Button Action methods
    
    @IBAction func btnUpcomingClicked(_ sender: Any) {
        if isSuccess{
            if Constants.deviceType == DeviceType.iPhone.rawValue{
                navigateToUpcomingFlights()
            }else{
                removeIpad(asChildViewController: MyTripsiPad)
                addIpad(asChildViewController: UpcomingFlightsiPad)
            }
        }
    }
    
    
    @IBAction func btnCancelledClicked(_ sender: Any) {
        if isSuccess{
            if Constants.deviceType == DeviceType.iPhone.rawValue{
                navigateToCancelledFlights()
            }else{
                removeIpad(asChildViewController: MyTripsiPad)
                addIpad(asChildViewController: CancelledFlightsiPad)
            }
        }
       
    }
    
    @IBAction func btnCompletedClicked(_ sender: Any) {
        if isSuccess{
            if Constants.deviceType == DeviceType.iPhone.rawValue{
                navigateToCompletedFlights()
            }else{
                removeIpad(asChildViewController: MyTripsiPad)
                addIpad(asChildViewController: CompletedFlightsiPad)
            }
        }
    }
    
}

extension MyTripViewController: BookedFlightListProtocol {
    var controller: MyTripViewController {
        self
    }
}
