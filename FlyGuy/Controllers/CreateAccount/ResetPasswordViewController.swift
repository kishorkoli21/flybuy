//
//  ResetPasswordViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 19/05/23.
//

import UIKit

protocol ResetPasswordProtocol {
    var controller: ResetPasswordViewController { get }
}

class ResetPasswordViewController: BaseViewController {

    @IBOutlet weak var txtFNewPassword: UITextField!
    @IBOutlet weak var txtFRenterPassword: UITextField!
    @IBOutlet weak var txtFEnterOtp: UITextField!
    
    @IBOutlet weak var btnReenterPass: UIButton!
    @IBOutlet weak var btnPassword: UIButton!
    
    var iconClick = true
    var iconClick1 = true
    var viewModel = CreateAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: Validation Textfields Methods
    
    func validate() -> Bool {
     
        if txtFEnterOtp.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.OTP)
            return false
        }
        
        if txtFNewPassword.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.Password)
            return false
        }
        
        if txtFRenterPassword.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.ReenterPassword)
            return false
        }
       
        return true
    }
    
    // MARK: Api Configure Methods
    
    func configure(){
        viewModel.resetView = self
        viewModel.getResetPasswordAPI(token: txtFEnterOtp.text!, password: txtFNewPassword.text!, repassword: txtFRenterPassword.text!) { isSuccess in
            if isSuccess{
                self.navigateToSuccessScreen()
            }
        }
    }
    
    // MARK: Navigation Methods
    
    func navigateToSuccessScreen(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: ResetPasswordiPad)
            addIpad(asChildViewController: SuccessiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.SuccessViewController) as! SuccessViewController
            // vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Button Action Methods
    
    @IBAction func btnHidePasswordClicked(_ sender: Any) {
        if iconClick {
            btnPassword.isSelected = false
            txtFNewPassword.isSecureTextEntry =  true
           } else {
               btnPassword.isSelected = true
               txtFNewPassword.isSecureTextEntry = false
           }
           iconClick = !iconClick
    }
    
    
    @IBAction func btnHideReenterPasswordClicked(_ sender: Any) {
        if iconClick1 {
            btnReenterPass.isSelected = false
            txtFRenterPassword.isSecureTextEntry = true
           } else {
            btnReenterPass.isSelected = true
            txtFRenterPassword.isSecureTextEntry = false
           }
           iconClick1 = !iconClick1
    }
    
    
    
    @IBAction func btnResetClicked(_ sender: Any) {
        if validate(){
            configure()
        }
        
    }
    
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: ResetPasswordiPad)
            addIpad(asChildViewController: ForgotPasswordiPad)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension ResetPasswordViewController: ResetPasswordProtocol {
    var controller: ResetPasswordViewController {
        self
    }
}
