//
//  AddAddressViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 01/08/23.
//

import UIKit

class AddAddressViewController: BaseViewController {

    
    @IBOutlet weak var txtFAddress: UITextField!
    @IBOutlet weak var txtFZipcode: UITextField!
    @IBOutlet weak var txtFFirstName: UITextField!
    @IBOutlet weak var txtFLastName: UITextField!
    @IBOutlet weak var txtFCity: UITextField!
    @IBOutlet weak var txtFState: UITextField!
    
    var model : PaymentDetailsStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if VIEWMANAGER.isShowPaymentAddressForIpad{
            txtFFirstName.text = VIEWMANAGER.paymentModel.firstName
            txtFLastName.text = VIEWMANAGER.paymentModel.lastName
            txtFAddress.text = VIEWMANAGER.paymentModel.address
            txtFZipcode.text = VIEWMANAGER.paymentModel.zipcode
            txtFCity.text = VIEWMANAGER.paymentModel.city
            txtFState.text = VIEWMANAGER.paymentModel.state
        }
    }
    
    // MARK: Validation Textfields Methods
    
    func validate() -> Bool {
        if txtFFirstName.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.firstName)
            return false
        }
        if txtFLastName.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.LastName)
            return false
        }
        if txtFAddress.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.Address)
            return false
        }
        if txtFCity.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.City)
            return false
        }
        if txtFState.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.State)
            return false
        }
        if txtFZipcode.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.Zipcode)
            return false
        }
        return true
    }
    
    // MARK: Navigation methods
    
    func navigateToPaymentScreen(){
        let storyID = UIStoryboard(name: Storyboards.PaymentGatewayStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.PaymentViewController) as! PaymentViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Button Action methods
 
    @IBAction func btnProceedClicked(_ sender: Any) {
        if validate(){
            VIEWMANAGER.paymentModel.firstName = txtFFirstName.text!
            VIEWMANAGER.paymentModel.lastName = txtFLastName.text!
            VIEWMANAGER.paymentModel.address = txtFAddress.text!
            VIEWMANAGER.paymentModel.zipcode = txtFZipcode.text!
            VIEWMANAGER.paymentModel.city = txtFCity.text!
            VIEWMANAGER.paymentModel.state = txtFState.text!
            if Constants.deviceType == DeviceType.iPad.rawValue{
                removeIpad(asChildViewController: self.AddAddressAuthorizeiPad)
                addIpad(asChildViewController: self.PaymentAuthorizeiPad)
            }else{
                navigateToPaymentScreen()
            }
        }
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: self.AddAddressAuthorizeiPad)
            addIpad(asChildViewController: self.CheckoutAuthorizeiPad)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
