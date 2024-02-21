//
//  VerificationViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 19/05/23.
//

import UIKit

class VerificationViewController: BaseViewController {

    
    @IBOutlet weak var lblEMail: UILabel!
    
    @IBOutlet weak var txtFOTP: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: Navigation Methods
    
    func navigateToResetPassword(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: VerificationiPad)
            addIpad(asChildViewController: ResetPasswordiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.CreateAccountStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ResetPasswordViewController) as! ResetPasswordViewController
            // vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Button Action Methods
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        navigateToResetPassword()
    }
    

}
