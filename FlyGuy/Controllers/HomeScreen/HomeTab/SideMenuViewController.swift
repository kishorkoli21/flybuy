//
//  SideMenuViewController.swift
//  FlyGuy
//
//  Created by Mac on 15/03/23.
//

import UIKit

class SideMenuViewController: BaseViewController {

    @IBOutlet weak var sideMenuContainerView: UIView!
    @IBOutlet weak var backMainView: UIView!
    @IBOutlet weak var sideMenuTabelView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    var menuArray = [Messages.help,Messages.aboutUs,Messages.contactUs]
    var imageArray = [#imageLiteral(resourceName: "Help"), #imageLiteral(resourceName: "AboutUs") , #imageLiteral(resourceName: "ContactUs")]
    
    var helpCallBack: ((_ submit: Bool) -> Void)?
    var aboutUsCallBack: ((_ submit: Bool) -> Void)?
    var contactUsCallBack: ((_ submit: Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTabelView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.setValue(false, forKey: "isSlideMenuOpened")
        UserDefaults.standard.synchronize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        if touch?.view == backMainView {
            closeSideMenu()
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        closeSideMenu()
    }
    
    @objc func dismissViewClicked(_ sender: UITapGestureRecognizer? = nil) {
        closeSideMenu()
    }

    func closeSideMenu(){
        let transition = CATransition()
        transition.duration = 0
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.SideMenuTableViewCell) as! SideMenuTableViewCell
        cell.nameLabel.text = menuArray[indexPath.row]
        cell.imgView.image = imageArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            closeSideMenu()
            self.helpCallBack?(true)
        case 1 :
            closeSideMenu()
            self.aboutUsCallBack?(true)
        case 2 :
            closeSideMenu()
            self.contactUsCallBack?(true)
        default:
            print("defalut")
        }
    }
    
}
