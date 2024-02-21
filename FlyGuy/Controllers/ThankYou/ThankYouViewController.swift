//
//  ThankYouViewController.swift
//  FlyGuy
//
//  Created by Mac on 03/04/23.
//

import UIKit

class ThankYouViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func gotoHomeButtonClicked(_ sender: UIButton) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            moveToMainContaineripadVCBase()
        }else{
            moveToTabBar()
        }
    }
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
//    func moveToHomeVCiPad(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeiPadStoryboard, bundle:nil)
//        let homeVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.HomeViewController) as! HomeViewController
//        homeVC.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(homeVC, animated: true)
//    }
    
    
}
