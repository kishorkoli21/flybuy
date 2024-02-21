//
//  PersonalInfoViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 03/07/23.
//

import UIKit

class PersonalInfoViewController: BaseViewController {
    
    @IBOutlet weak var viewBGProfile: UIView!
    @IBOutlet weak var viewBGForgotPassword: UIView!
    @IBOutlet weak var viewBGResetPassword: UIView!
    @IBOutlet weak var ViewBGLogout: UIView!
    @IBOutlet weak var ViewBGlogin: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBGProfile.addShadowForCell()
        viewBGForgotPassword.addShadowForCell()
        viewBGResetPassword.addShadowForCell()
        ViewBGlogin.addShadowForCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ViewManager.shared.isLogin{
            ViewBGlogin.isHidden = true
            ViewBGLogout.isHidden = false
            viewBGResetPassword.isHidden = false
        }else{
            ViewBGlogin.isHidden = false
            ViewBGLogout.isHidden = true
            viewBGResetPassword.isHidden = true
        }
    }
    
    // MARK: Navigation setup methods
    
    func navigateToCreateAccount(){
        ViewManager.shared.isCreateAccountFromTabBar = true
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: PersonalInfoiPad)
            addIpad(asChildViewController: ProfileiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.ProfileStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
            // vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToForgotPasswordScreen(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: PersonalInfoiPad)
            addIpad(asChildViewController: ForgotPasswordiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ForgotPasswordViewController) as! ForgotPasswordViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToChangePasswordScreen(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: PersonalInfoiPad)
            addIpad(asChildViewController: ChangePasswordiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ChangePasswordViewController) as! ChangePasswordViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    func moveToMainContaineripadVC(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.MainiPadContanerStoryboard, bundle:nil)
        let MainContaineriPadVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.MainiPadContainerViewController) as! MainiPadContainerViewController
        MainContaineriPadVC.isFromipadOnboarding = true
        MainContaineriPadVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(MainContaineriPadVC, animated: true)
    }
    
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
    
    // MARK: Button Actions methods
    
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        if ViewManager.shared.isLogin{
            Preferences.clearLoginResponse()
            Preferences.clearSignUpResponse()
            ViewManager.shared.isLogin = false
            if Constants.deviceType == DeviceType.iPad.rawValue{
                removeIpad(asChildViewController: PersonalInfoiPad)
                moveToMainContaineripadVC()
            }else{
                moveToTabBar()
            }
        }else{
            VIEWMANAGER.showToast(message: "You are not login yet")
        }
    }
    
    @IBAction func btnProfileClicked(_ sender: Any) {
        navigateToCreateAccount()
    }
    
    
    @IBAction func btnForgotPasswordClicked(_ sender: Any) {
        navigateToForgotPasswordScreen()
    }
    
    
    @IBAction func btnResetPasswordClicked(_ sender: Any) {
        navigateToChangePasswordScreen()
    }
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        VIEWMANAGER.isFromLoginBtn = true
        VIEWMANAGER.isCreateAccountFromTabBar = true
        navigateToLoginScreen()
    }
    
}
