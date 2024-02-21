//
//  ProfileViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 18/05/23.
//

import UIKit

protocol SignUpProtocol {
    var controller: ProfileViewController { get }
}

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var txtFFirstName: UITextField!
    @IBOutlet weak var txtFLastName: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFCreatePassword: UITextField!
    @IBOutlet weak var txtFReEnterPassword: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var viewHomeButton: UIView!
    @IBOutlet weak var txtFPhoneNumber: UITextField!
    @IBOutlet weak var viewRegisterLogin: UIView!
    @IBOutlet weak var viewCreatePassword: UIView!
    @IBOutlet weak var viewReenterPassword: UIView!
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var txtFDOB: UITextField!
    @IBOutlet weak var btnShowHideRenter: UIButton!
    
    var iconClick = true
    var iconClick1 = true
    var viewModel = ProfileViewModel()
    var signUpStruct = SignUpParameterKeyStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
  
    // MARK: Initial View setup methods
    
    func setUpUI(){
        if let dict = Preferences.getSignUpResponse() {
            txtFEmail.text = dict["email"] as? String
            txtFPhoneNumber.text = dict["number"] as? String
            txtFFirstName.text = dict["firstname"] as? String
            txtFLastName.text = dict["lastname"] as? String
            txtFDOB.text = dict["birthdate"] as? String
            viewCreatePassword.isHidden = true
            viewReenterPassword.isHidden = true
            self.lblTitle.text = "Edit Account"
            self.lblNavTitle.text = "Edit Account"
            viewRegisterLogin.isHidden = true
        }else{
            if let dict = Preferences.getLoginResponse(){
                txtFEmail.text = dict["email"] as? String
                txtFPhoneNumber.text = dict["number"] as? String
                txtFFirstName.text = dict["firstname"] as? String
                txtFLastName.text = dict["lastname"] as? String
                txtFDOB.text = dict["birthdate"] as? String
                viewCreatePassword.isHidden = true
                viewReenterPassword.isHidden = true
                self.lblTitle.text = "Edit Account"
                self.lblNavTitle.text = "Edit Account"
                viewRegisterLogin.isHidden = true
            }
        }
    }
    
    func validate() -> Bool {
        if txtFFirstName.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.firstName)
            return false
        }
        if txtFLastName.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.LastName)
            return false
        }
        if txtFEmail.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.Email)
            return false
        }
        if !txtFEmail.text!.isValidEmail() {
            self.showAlert(msg: Messages.ValidEmail)
            return false
        }
        
        if txtFPhoneNumber.text!.trimString().count == 0  {
            self.showAlert(msg: Messages.PhoneNumber)
            return false
        }
        
        if txtFDOB.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.DOB)
            return false
        }
        
        if ViewManager.shared.isLogin == false{
            
            if txtFCreatePassword.text!.trimString().count == 0 {
                self.showAlert(msg: Messages.Password)
                return false
            }
            
            else if txtFCreatePassword.text!.count < 4 {
                self.showAlert(msg: Messages.ValidPassword)
                return false
            }
            
            if txtFReEnterPassword.text!.trimString().count == 0 {
                self.showAlert(msg: Messages.ConfirmPassword)
                return false
            }
            
            if txtFCreatePassword.text! != txtFReEnterPassword.text! {
                self.showAlert(msg: Messages.PasswordMatch)
                return false
            }
        }
        
        return true
    }
    
    func getAgeFromDOF(date: String) -> (Int,Int,Int) {

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateOfBirth = dateFormater.date(from: date)

        let calender = Calendar.current

        let dateComponent = calender.dateComponents([.year, .month, .day], from:
        dateOfBirth!, to: Date())

        return (dateComponent.year!, dateComponent.month!, dateComponent.day!)
    }
    
    // MARK: Navigation methods
    
    func navigateToLoginScreen(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: ProfileiPad)
            addIpad(asChildViewController: LoginiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.LoginViewController) as! LoginViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Api integration methods
    
    func configure(){
        signUpStruct.email = txtFEmail.text
        signUpStruct.password = txtFCreatePassword.text
        signUpStruct.phonenumber = txtFPhoneNumber.text
        signUpStruct.firstname = txtFFirstName.text
        signUpStruct.lastname = txtFLastName.text
        signUpStruct.dob = txtFDOB.text
        
        viewModel.view = self
        if let dict = Preferences.getLoginResponse(){
            let email =  dict["email"] as? String
            let token =  dict["token"] as? String
            if email != "" || email != nil && token != "" || token != nil{
                ViewManager.shared.isLogin = true
            }
            else{
                ViewManager.shared.isLogin = false
            }
        }
        if !ViewManager.shared.isLogin{
            viewModel.getSignUpDoneAPI(inputParameters: signUpStruct) { isSuccess in
                if isSuccess{
                    let dict : NSDictionary = ["firstname": self.signUpStruct.firstname ?? "",
                                               "lastname": self.signUpStruct.lastname ?? "",
                                               "email": self.signUpStruct.email ?? "",
                                               "password": self.signUpStruct.password ?? "",
                                               "number": self.signUpStruct.phonenumber ?? "",
                                               "birthdate" : self.signUpStruct.dob ?? ""]
                    Preferences.saveSignUpResponse(response: dict)
                    ViewManager.shared.isLogin = false
                    if ViewManager.shared.isCreateAccountFromTabBar {
                        self.lblTitle.text = "Edit Account"
                        self.lblNavTitle.text = "Edit Account"
                        self.viewRegisterLogin.isHidden = true
                        self.viewCreatePassword.isHidden = true
                        self.viewReenterPassword.isHidden = true
                    }else{
                      //  ViewManager.shared.isCreateAccountFromTabBar = true
                        self.navigateToLoginScreen()
                        //self.navigateToTravelerDetails()
                    }
                }
            }
        }else{
            viewModel.getProfileUpdateDoneAPI(inputParameters: signUpStruct) { isSuccess in
                if isSuccess{
                    let dict : NSDictionary = ["firstname": self.signUpStruct.firstname ?? "",
                                               "lastname": self.signUpStruct.lastname ?? "",
                                               "email": self.signUpStruct.email ?? "",
                                               "password": self.signUpStruct.password ?? "",
                                               "number": self.signUpStruct.phonenumber ?? "",
                                               "birthdate" : self.signUpStruct.dob ?? ""
                    ]
                    Preferences.saveSignUpResponse(response: dict)
                    if ViewManager.shared.isCreateAccountFromTabBar {
                        self.lblTitle.text = "Edit Account"
                        self.lblNavTitle.text = "Edit Account"
                    }
                }
            }
        }
    }
    
    // MARK: Button Action methods
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        navigateToLoginScreen()
    }
    
    @IBAction func btnShowHidePasswordClicked(_ sender: Any) {
        if iconClick {
            btnPassword.isSelected = false
            txtFCreatePassword.isSecureTextEntry = true
        } else {
            btnPassword.isSelected = true
            txtFCreatePassword.isSecureTextEntry = false
        }
        iconClick = !iconClick
        
    }
    
    
    
    @IBAction func btnShowHideReenterPass(_ sender: Any) {
        if iconClick1 {
            btnShowHideRenter.isSelected = false
            txtFReEnterPassword.isSecureTextEntry = true
        } else {
            btnShowHideRenter.isSelected = true
            txtFReEnterPassword.isSecureTextEntry = false
        }
        iconClick1 = !iconClick1
    }
    
    @IBAction func btnRegisterClicked(_ sender: Any) {
        if validate(){
            configure()
        }
    }
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            navigationController?.popViewController(animated: true)
        }else{
            removeIpad(asChildViewController: ProfileiPad)
            if VIEWMANAGER.isFromLoginBtn{
                addIpad(asChildViewController: PersonalInfoiPad)
            }
            else if VIEWMANAGER.isReturn{
                addIpad(asChildViewController: FlightListInboundVCiPad)
            }
            else{
                addIpad(asChildViewController: FlightListVCiPad)
            }
        }
    }
    
    @IBAction func btnDOBClicked(_ sender: Any) {
        ViewManager.shared.isDOB = true
        let datePicker = DatePickerView(frame: UIScreen.main.bounds)
        self.view.addSubview(datePicker)
        datePicker.onDoneClicked { (date) in
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let jorneyDate = formatter.date(from: date)
            formatter.dateFormat = "yyyy-MM-dd"
            let changedDate = formatter.string(from: jorneyDate ?? Date())
            let age = self.getAgeFromDOF(date: changedDate)
            if age.0 < 18 {
                VIEWMANAGER.showToast(message: Messages.ageVaildation)
            }else{
                self.txtFDOB.text = changedDate
            }
        }
        ViewManager.shared.isDOB = false
    }
    
}

extension ProfileViewController: SignUpProtocol {
    var controller: ProfileViewController {
        self
    }
}
