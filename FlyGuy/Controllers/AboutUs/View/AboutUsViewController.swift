//
//  AboutUsViewController.swift
//  FlyGuy
//
//  Created by Mac on 20/03/23.
//

import UIKit

class AboutUsViewController: BaseViewController {
    
    @IBOutlet weak var sideMenuAboutUsContainerView: UIView!
    @IBOutlet weak var aboutUsTextLabel: UILabel!
    @IBOutlet weak var aboutUsDescLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusBarBackgroundColor(colorHex: AppColor.statusBarColor)
        setLabelData()
    }
    
    //MARK: - Initial Setup method
    
    func setLabelData(){
        aboutUsTextLabel.text = Messages.aboutUs
        aboutUsDescLabel.text = Messages.aboutUsDescription
    }
    
    //MARK: - Button Action method
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
