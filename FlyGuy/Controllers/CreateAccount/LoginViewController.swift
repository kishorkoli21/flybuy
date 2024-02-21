//
//  LoginViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 02/05/23.
//

import UIKit

protocol SignInProtocol {
    var controller: LoginViewController { get }
}

class LoginViewController: BaseViewController {

   
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPassword: UITextField!
    @IBOutlet weak var btnPassword: UIButton!
    
    var iconClick = true
    var viewModel = CreateAccountViewModel()
    var signInStruct = SignInParameterKeyStruct()
    
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
       
        if txtFPassword.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.Password)
            return false
        }
      
        return true
    }
    
    // MARK: Api Configure Methods
    
    func configure(){
        viewModel.view = self
        viewModel.getSignInDoneAPI(inputParameters: signInStruct) { isSuccess in
            if isSuccess{
                ViewManager.shared.isLogin = true
                if ViewManager.shared.isCreateAccountFromTabBar{
                    if VIEWMANAGER.isFromLoginBtn{
                        if Constants.deviceType == DeviceType.iPad.rawValue{
                            self.removeIpad(asChildViewController: self.LoginiPad)
                            self.addIpad(asChildViewController: self.PersonalInfoiPad)
                        }else{
                            self.moveToTabBar()
                        }
                    }else{
                        self.navigateToCreateAccount()
                    }
                }else{
                    self.navigateToFlightDetails()
                }
            }
        }
    }
    
    // MARK: Navigation Methods
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    func navigateToForgotPasswordScreen(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: LoginiPad)
            addIpad(asChildViewController: ForgotPasswordiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ForgotPasswordViewController) as! ForgotPasswordViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToCreateAccount(){
        ViewManager.shared.isCreateAccountFromTabBar = false
        if Constants.deviceType == DeviceType.iPad.rawValue{
            ViewManager.shared.isCreateAccountFromTabBar = true
            removeIpad(asChildViewController: LoginiPad)
            addIpad(asChildViewController: ProfileiPad)
        }else{
           // self.navigationController?.popViewController(animated: true)
            let storyID = UIStoryboard(name: Storyboards.ProfileStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToFlightDetails(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: LoginiPad)
            addIpad(asChildViewController: FlightDetailsVCiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.FlightListStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightDetailsViewController) as! FlightDetailsViewController
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Button Action Methods
    
    @IBAction func btnForgotPasswordClicked(_ sender: Any) {
        navigateToForgotPasswordScreen()
    }
    
    
    @IBAction func btnRegisterUserClicked(_ sender: Any) {
        navigateToCreateAccount()
    }
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            if VIEWMANAGER.isFromLoginBtn || VIEWMANAGER.isCreateAccountFromTabBar{
                removeIpad(asChildViewController: LoginiPad)
                addIpad(asChildViewController: PersonalInfoiPad)
            }
//            else if VIEWMANAGER.isCreateAccountFromTabBar{
//                removeIpad(asChildViewController: LoginiPad)
//                addIpad(asChildViewController: ProfileiPad)
//            }
            else if VIEWMANAGER.isReturn {
                removeIpad(asChildViewController: LoginiPad)
                addIpad(asChildViewController: FlightListInboundVCiPad)
            }else{
                removeIpad(asChildViewController: LoginiPad)
                addIpad(asChildViewController: FlightListVCiPad)
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func btnShowHidePasswordClicked(_ sender: Any) {
        if iconClick {
            btnPassword.isSelected = false
            txtFPassword.isSecureTextEntry = true
           } else {
               btnPassword.isSelected = true
            txtFPassword.isSecureTextEntry = false
           }
           iconClick = !iconClick
    }
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        signInStruct.email = txtFEmail.text
        signInStruct.password = txtFPassword.text
        if validate(){
            configure()
        }
    }
   
}

extension LoginViewController: SignInProtocol {
    var controller: LoginViewController {
        self
    }
}
