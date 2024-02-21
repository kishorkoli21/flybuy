//
//  CreateAccountViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 02/05/23.
//

import UIKit

class CreateAccountViewController: BaseViewController {

    @IBOutlet weak var txtFFirstName: UITextField!
    @IBOutlet weak var txtFLastName: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFCreatePassword: UITextField!
    @IBOutlet weak var txtFReEnterPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: Validation Textfields Methods
    
    func validate() -> Bool {
        if txtFFirstName.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.firstName)
            return false
        }
        if txtFLastName.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.firstName)
            return false
        }
        if txtFEmail.text!.trimString().count == 0 {
            VIEWMANAGER.showToast(message: Messages.Email)
            return false
        }
        if !txtFEmail.text!.isValidEmail() {
            VIEWMANAGER.showToast(message: Messages.ValidEmail)
            return false
        }
       
        if txtFCreatePassword.text!.trimString().count == 0 {
            VIEWMANAGER.showToast(message: Messages.Password)
            return false
        }
        
        else if txtFCreatePassword.text!.count < 4 {
            VIEWMANAGER.showToast(message: Messages.ValidPassword)
            return false
        }
        
        if txtFReEnterPassword.text!.trimString().count == 0 {
            VIEWMANAGER.showToast(message: Messages.ConfirmPassword)
            return false
        }
        
        if txtFCreatePassword.text! != txtFReEnterPassword.text! {
            VIEWMANAGER.showToast(message: Messages.PasswordMatch)
            return false
        }
        
        return true
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
    }
    
    @IBAction func btnShowHidePasswordClicked(_ sender: Any) {
    }
    
    @IBAction func btnRegisterClicked(_ sender: Any) {
    }
    
    @IBAction func btnHomeClicked(_ sender: Any) {
    }
    
}
