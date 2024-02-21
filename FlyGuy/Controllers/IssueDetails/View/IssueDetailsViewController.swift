//
//  IssueDetailsViewController.swift
//  FlyGuy
//
//  Created by Mac on 20/03/23.
//

import UIKit

class IssueDetailsViewController: BaseViewController {

    @IBOutlet weak var issueNameLabel: UILabel!
    @IBOutlet weak var sideMenuIssueDetailsContainerView: UIView!
    
    var selectedIssueName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusBarBackgroundColor(colorHex: AppColor.statusBarColor)
        issueNameLabel.text = selectedIssueName
    }
    
    //MARK: - Button Action method
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
