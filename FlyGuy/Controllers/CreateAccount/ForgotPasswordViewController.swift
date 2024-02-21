//
//  ForgotPasswordViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 19/05/23.
//

import UIKit

protocol ForgotPasswordProtocol {
    var controller: ForgotPasswordViewController { get }
}

class ForgotPasswordViewController: BaseViewController {

    
    @IBOutlet weak var txtFEmail: UITextField!
    
    var viewModel = CreateAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: Validation Textfields Methods
    
    func validate() -> Bool {
     
        if txtFEmail.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.Email)
            return false
        }
        if !txtFEmail.text!.isValidEmail() {
            self.showAlert(msg: Messages.ValidEmail)
            return false
        }
       
        return true
    }
    // MARK: Api Configure Methods
    
    func configure(){
        viewModel.forgotView = self
        viewModel.getForgotPasswordAPI(inputParameters: txtFEmail.text ?? "") { isSuccess in
            if isSuccess{
                self.navigateToResetPassword()
            }
        }
    }
    
    // MARK: Navigation Methods
    
    func navigateToResetPassword(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: ForgotPasswordiPad)
            addIpad(asChildViewController: ResetPasswordiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ResetPasswordViewController) as! ResetPasswordViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Button Action Methods
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: ForgotPasswordiPad)
            addIpad(asChildViewController: PersonalInfoiPad)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        if validate(){
            configure()
        }
    }
    
}


extension ForgotPasswordViewController: ForgotPasswordProtocol {
    var controller: ForgotPasswordViewController {
        self
    }
}
