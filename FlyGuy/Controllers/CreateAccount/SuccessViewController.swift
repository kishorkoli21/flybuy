//
//  SuccessViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 19/05/23.
//

import UIKit
import Lottie

class SuccessViewController: BaseViewController {

    
    @IBOutlet weak var viewGif: LottieAnimationView!

    override func viewDidLoad() {
      super.viewDidLoad()
        let animationView = LottieAnimationView(name: "88860-success-animation")
        if Constants.deviceType == DeviceType.iPad.rawValue{
            animationView.translatesAutoresizingMaskIntoConstraints = false
            animationView.contentMode = .scaleAspectFit
        }else{
            animationView.frame = CGRect(x: 0, y: 0, width: viewGif.frame.width, height: viewGif.frame.height)
            animationView.contentMode = .scaleAspectFit
        }
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        viewGif.addSubview(animationView)
        if Constants.deviceType == DeviceType.iPad.rawValue{
            animationView.leadingAnchor.constraint(equalTo: viewGif.leadingAnchor).isActive = true
            animationView.trailingAnchor.constraint(equalTo: viewGif.trailingAnchor).isActive = true
            animationView.topAnchor.constraint(equalTo: viewGif.topAnchor).isActive = true
            animationView.bottomAnchor.constraint(equalTo: viewGif.bottomAnchor).isActive = true
        }
        animationView.play()
      
    }
    
    // MARK: Navigation Methods
    
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
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    // MARK: Button Action Methods
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        navigateToLoginScreen()
    }
    
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: SuccessiPad)
            addIpad(asChildViewController: PersonalInfoiPad)
        }else{
            moveToTabBar()
        }
    }
    
}
