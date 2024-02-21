//
//  SplashScreenViewController.swift
//  FlyGuy
//
//  Created by Mac on 14/03/23.
//

import UIKit

class SplashScreenViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.startingScreen()
        }
    }
    
    func startingScreen() {
        let isAlreadyShowOnboardScreen = UserDefaults.standard.value(forKey: Constants.isShowOnBoardScreen) as? Bool ?? false
        
        let isAlreadyShowOnboardScreenForiPad = UserDefaults.standard.value(forKey: Constants.isShowOnBoardScreeniPad) as? Bool ?? false
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            Constants.deviceType = DeviceType.iPhone.rawValue
            if isAlreadyShowOnboardScreen == true{
                moveToTabBar()
            }else{
                showOnboardingScreen()
            }
        }else{
            Constants.deviceType = DeviceType.iPad.rawValue
            if isAlreadyShowOnboardScreenForiPad == true{
                //moveToHomeVCiPad()
                moveToMainContaineripadVC()
            }else{
                showOnboardingScreeniPad()
            }
        }
    
    }
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    func showOnboardingScreen(){
        let storyboard = UIStoryboard(name: Storyboards.OnboardingStoryboard, bundle:nil)
        let onboardingVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.OnboardingViewController) as! OnboardingViewController
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
    func moveToMainContaineripadVC(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.MainiPadContanerStoryboard, bundle:nil)
        let MainContaineriPadVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.MainiPadContainerViewController) as! MainiPadContainerViewController
        MainContaineriPadVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(MainContaineriPadVC, animated: true)
    }
    
    func showOnboardingScreeniPad(){
        let storyboard = UIStoryboard(name: Storyboards.OnboardingiPadStoryboard, bundle:nil)
        let onboardingVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.OnboardingViewController) as! OnboardingViewController
        onboardingVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }

}
