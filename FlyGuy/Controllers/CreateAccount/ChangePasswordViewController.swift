//
//  ChangePasswordViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 03/07/23.
//

import UIKit

protocol ChangePasswordProtocol {
    var controller: ChangePasswordViewController { get }
}

class ChangePasswordViewController: BaseViewController {
    
   
    @IBOutlet weak var txtFOldPassword: UITextField!
    @IBOutlet weak var txtFNewPassword: UITextField!
    @IBOutlet weak var btnNewPass: UIButton!
    @IBOutlet weak var btnOldPass: UIButton!
    
    var viewModel = CreateAccountViewModel()
    var iconClick = true
    var iconClick1 = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: Validation Textfields Methods
    
    func validate() -> Bool {
     
        if txtFOldPassword.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.OldPassword)
            return false
        }
        
        if txtFNewPassword.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.NewPassword)
            return false
        }
       
        return true
    }
    
    // MARK: Api Configuration Methods
    
    func configure(){
        viewModel.changeView = self
        viewModel.getChangePasswordAPI(email: VIEWMANAGER.loginDetails.email ?? "", password: txtFNewPassword.text ?? "", Oldpassword: txtFOldPassword.text ?? "") { isSuccess in
            if isSuccess{
                self.navigateToSuccessScreen()
            }
        }
    }
    
    // MARK: Navigation Methods
    
    func navigateToSuccessScreen(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: ChangePasswordiPad)
            addIpad(asChildViewController: SuccessiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.SuccessViewController) as! SuccessViewController
            // vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Button Action Methods
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: ChangePasswordiPad)
            addIpad(asChildViewController: PersonalInfoiPad)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnResetPasswordClicked(_ sender: Any) {
        if validate(){
            configure()
        }
    }
    
    
    @IBAction func btnShowHideOldPass(_ sender: Any) {
        if iconClick {
            btnOldPass.isSelected = false
            txtFOldPassword.isSecureTextEntry = true
        } else {
            btnOldPass.isSelected = true
            txtFOldPassword.isSecureTextEntry = false
        }
        iconClick = !iconClick
    }
    
    
    @IBAction func btnShowHideNewPassClicked(_ sender: Any) {
        if iconClick1 {
            btnNewPass.isSelected = false
            txtFNewPassword.isSecureTextEntry = true
        } else {
            btnNewPass.isSelected = true
            txtFNewPassword.isSecureTextEntry = false
        }
        iconClick1 = !iconClick1
    }
    
}

extension ChangePasswordViewController: ChangePasswordProtocol {
    var controller: ChangePasswordViewController {
        self
    }
}
